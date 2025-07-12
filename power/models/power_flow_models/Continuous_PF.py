from power.models.power_flow_models import AC_PF
import numpy as np

class CPF(AC_PF):
    def __init__(self, network):
        super().__init__(network)

    def prediction(self):
        pass

    def correction(self):
        pass

    def CPF_(self, bus_idx, step):
        self.solve(tol_P=1e-6, tol_Q=1e-6, max_iter=100, verbose=False) #Base case solution
        lambda_corr = 0
        #Prediction phase:
        J = self.jacobian(theta=np.deg2rad(self.theta), V=self.V, P=self.P, Q=self.Q) #Jacobian in the base case
        dP_dl = self.network.buses[bus_idx].p 
        dQ_dl = self.network.buses[bus_idx].q
        df_dl = np.zeros(2*self.nbus)
        df_dl[bus_idx] = dP_dl
        df_dl[self.nbus+bus_idx] = dQ_dl

        J_aug = np.zeros((2*self.nbus+1, 2*self.nbus+1))
        J_aug[:2 * self.nbus, :2 * self.nbus] = J
        J_aug[:2 * self.nbus, -1] = df_dl
        J_aug[-1, -1] = 1  # Força dλ/dλ = 1

        rhs = np.zeros(2*self.nbus+1)
        rhs[-1] = step

        dx = np.linalg.solve(J_aug, rhs)
        dtheta = dx[:self.nbus]
        theta_pred = np.deg2rad(self.theta) + dtheta
        dV = dx[self.nbus:2*self.nbus]
        V_pred = self.V + dV
        dl = dx[-1]
        lambda_pred = lambda_corr + dl

        #Correction phase: NR loop
        theta = theta_pred.copy()
        V = V_pred.copy()
        lambda_val = lambda_pred
        tol = 1e-6
        max_iter = 20

        for iter in range(max_iter):
            P_calc, Q_calc = self.pq_calc(theta, V)
            dP, dQ = self.power_mismatch(P_calc, Q_calc)
            dX = np.concatenate((dP, dQ))
            #dX_aug = np.append(dX, )
            J = self.jacobian(theta, V, P_calc, Q_calc)
            J_aug = 2




    def _CPF(self, bus_idx, step=0.01, max_lambda=10.0, max_outer_iter=100):
        """
        Executa o CPF completo (múltiplos passos de predição + correção).
        """
        # Resolve o caso base
        self.solve(verbose=False)
        lambda_val = 0

        # Inicializa variáveis de estado
        theta = np.deg2rad(self.theta)
        V = self.V.copy()

        # Armazena histórico, se quiser plotar curva depois
        lambdas = [lambda_val]
        voltages = [V.copy()]

        for outer_iter in range(max_outer_iter):
            # ------------------
            # 1. PREDIÇÃO
            # ------------------
            J = self.jacobian(theta, V, *self.pq_calc(theta, V))

            dP_dl = self.P_esp[bus_idx]
            dQ_dl = self.Q_esp[bus_idx]
            df_dl = np.zeros(2 * self.nbus)
            df_dl[bus_idx] = dP_dl
            df_dl[self.nbus + bus_idx] = dQ_dl

            J_aug = np.zeros((2 * self.nbus + 1, 2 * self.nbus + 1))
            J_aug[:2 * self.nbus, :2 * self.nbus] = J
            J_aug[:2 * self.nbus, -1] = df_dl
            J_aug[-1, -1] = 1

            rhs = np.zeros(2 * self.nbus + 1)
            rhs[-1] = step

            dx = np.linalg.solve(J_aug, rhs)
            dtheta = dx[:self.nbus]
            dV = dx[self.nbus:2 * self.nbus]
            dl = dx[-1]

            theta_pred = theta + dtheta
            V_pred = V + dV
            lambda_pred = lambda_val + dl

            # ------------------
            # 2. CORREÇÃO
            # ------------------
            theta = theta_pred.copy()
            V = V_pred.copy()
            lambda_val = lambda_pred

            for load in self.network.loads:
                idx = self.bus_idx[load.bus.id]
                if idx == bus_idx:
                    load.p_input = self.P_esp[idx] * lambda_val
                    load.q_input = self.Q_esp[idx] * lambda_val

            converged = False
            for _ in range(20):  # Iterações NR internas
                P_calc, Q_calc = self.pq_calc(theta, V)
                dP, dQ = self.power_mismatch(P_calc, Q_calc)
                mismatch = np.concatenate((dP, dQ))

                if np.linalg.norm(mismatch, np.inf) < 1e-6:
                    converged = True
                    break

                J = self.jacobian(theta, V, P_calc, Q_calc)
                df_dl = np.zeros(2 * self.nbus)
                df_dl[bus_idx] = self.P_esp[bus_idx]
                df_dl[self.nbus + bus_idx] = self.Q_esp[bus_idx]

                J_aug = np.zeros((2 * self.nbus + 1, 2 * self.nbus + 1))
                J_aug[:2 * self.nbus, :2 * self.nbus] = J
                J_aug[:2 * self.nbus, -1] = df_dl
                J_aug[-1, -1] = 1

                rhs = np.zeros(2 * self.nbus + 1)
                rhs[:2 * self.nbus] = mismatch

                dx = np.linalg.solve(J_aug, rhs)
                dtheta = dx[:self.nbus]
                dV = dx[self.nbus:2 * self.nbus]
                dl = dx[-1]

                theta += dtheta
                V += dV
                lambda_val += dl

            if not converged:
                print(f"Iteração {outer_iter}: correção falhou. Parando.")
                break

            # Armazena histórico
            lambdas.append(lambda_val)
            voltages.append(V.copy())

            # Critério de parada
            if lambda_val >= max_lambda:
                print(f"Parou: λ = {lambda_val:.4f} >= {max_lambda}")
                break
            if np.any(V < 0.7):  # tensão colapsando
                print("Parou: tensão mínima violada.")
                break

        # Atualiza estado final
        self.theta = np.rad2deg(theta)
        self.V = V
        self.P, self.Q = self.pq_calc(theta, V)

        print("CPF finalizado.")
        self.print_sol()

        return lambdas, voltages






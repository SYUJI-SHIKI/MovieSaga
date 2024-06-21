import authApi from "./auth";

interface AuthResponse {
  data: {
    id: number;
    email: string;
    provider: string;
    uid: string;
    allow_password_change: boolean;
    name: string;
    nickname: string;
  };
}

const logIn = async (
  email: string,
  password: string
): Promise<AuthResponse> => {
  try {
    const response = await authApi.post<AuthResponse>(
      "/auth/sign_in",
      {
        email,
        password,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error("ログインできませんでした", error);
    throw error;
  }
};

export default logIn;

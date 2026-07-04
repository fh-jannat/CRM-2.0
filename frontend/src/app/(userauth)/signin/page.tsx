import Image from "next/image";
import { SignInForm } from "@/components/forms/signinForm/SignInForm";

export default function SignInPage() {
  return (
    <main className="relative flex min-h-screen items-center justify-center overflow-hidden bg-[#0f172a]">

      {/* Animated Background */}
      <div className="absolute inset-0">
        <div className="absolute -top-20 left-0 h-96 w-96 rounded-full bg-pink-600 opacity-30 blur-[140px]" />
        <div className="absolute bottom-0 right-0 h-96 w-96 rounded-full bg-blue-600 opacity-30 blur-[140px]" />
        <div className="absolute left-1/2 top-1/2 h-72 w-72 -translate-x-1/2 -translate-y-1/2 rounded-full bg-purple-500 opacity-20 blur-[130px]" />
    </div>

      {/* Glass Card */}

      <div className="relative w-full max-w-md rounded-[35px] border border-white/20 bg-white/10 p-10 shadow-2xl backdrop-blur-3xl">

        <div className="mb-8 flex flex-col items-center">

          <div className="mb-6 flex h-28 w-28 items-center justify-center rounded-full bg-white/10">

            <Image
              src="/navLogo.png"
              width={90}
              height={90}
              alt="logo"
            />

          </div>

          <h1 className="text-3xl font-bold text-white">
            Welcome Back
          </h1>

          <p className="mt-2 text-sm text-gray-300">
            Sign in to continue
          </p>

        </div>

        <SignInForm />

      </div>

    </main>
  );
}
import Link from "next/link";

export default function Home() {
  return (
    <div className="flex min-h-[calc(100vh-65px)] flex-col items-center justify-center bg-gray-50 px-4 text-center dark:bg-gray-900">
      <div className="max-w-md space-y-6">
        <h1 className="text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white sm:text-5xl">
          Track Management
        </h1>
        <p className="text-lg text-gray-600 dark:text-gray-400">
          Manage and track your music seamlessly. Sign in or create an account to get started.
        </p>
        <div className="flex justify-center gap-4">
          <Link
            href="/login"
            className="rounded-lg bg-blue-600 px-6 py-3 text-base font-medium text-white shadow-md hover:bg-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
          >
            Go to Login
          </Link>
        </div>
      </div>
    </div>
  );
}
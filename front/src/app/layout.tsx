import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import Header from "@/components/layouts/header/Header";
import Footer from "@/components/layouts/footer/Footer";
// import { Toaster } from "@/components/ui/toaster";
// import { Toaster as HotToaster } from "react-hot-toast";
const inter = Inter({ subsets: ["latin"] });

const siteName = "MovieSaga";
const description = "映画";
const url = "https://www.movie-saga-app.com/";

const metadata: Metadata = {
  metadataBase: new URL(url),
  title: {
    default: siteName,
    template: `%s - ${siteName}`,
  },
  description,
  openGraph: {
    title: siteName,
    description,
    url,
    siteName,
    locale: "ja_JP",
    type: "website",
  },
  twitter: {
    card: "summary",
    title: siteName,
    description,
    creator: "@ganbaritaiman9",
  },
  alternates: {
    canonical: url,
  },
};

const RootLayout = ({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) => {
  return (
    <html lang="ja">
      <body>
        <Header />
        {children}
        <Footer />
      </body>
    </html>
  );
};

export default RootLayout;

import "./globals.css";
import { Inter } from "next/font/google";
import Navbar from "@/components/Navbar";
import Web3walletProvider from "@/hooks/web3wallet";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className + "min-h-screen"}>
        <Web3walletProvider>
          <div>
            <Navbar />
            {children}
          </div>
        </Web3walletProvider>
      </body>
    </html>
  );
}
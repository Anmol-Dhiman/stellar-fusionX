import type React from "react";
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { UserProvider } from "@/context/user-context"; // Import UserProvider

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "StellarBridge - Cross-Chain DEX",
  description:
    "Bridge the future of DeFi with lightning-fast cross-chain swaps between Ethereum and Stellar",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <UserProvider>{children}</UserProvider> {/* Wrap with UserProvider */}
      </body>
    </html>
  );
}

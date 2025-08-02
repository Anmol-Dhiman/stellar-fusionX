"use client";

import type React from "react";
import { createContext, useContext, useState, useCallback } from "react";

interface UserData {
  email: string;
  ethPublicAddress: string;
  ethPrivateAddress: string;
  stellarPublicAddress: string;
  stellarPrivateAddress: string;
}

interface UserContextType {
  userData: UserData | null;
  setUserData: (data: UserData | null) => void;
  isConnected: boolean;
  setIsConnected: (connected: boolean) => void;
  hasEthConnection: boolean;
  hasStellarConnection: boolean;
  updateEthConnection: (
    ethPublicAddress: string,
    ethPrivateAddress?: string
  ) => void;
  updateStellarConnection: (
    stellarPublicAddress: string,
    stellarPrivateAddress?: string
  ) => void;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export function UserProvider({ children }: { children: React.ReactNode }) {
  const [userData, setUserDataState] = useState<UserData | null>(null);
  const [isConnected, setIsConnectedState] = useState(false);

  const setUserData = useCallback((data: UserData | null) => {
    setUserDataState(data);
    setIsConnectedState(!!data); // Set isConnected based on whether userData exists
  }, []);

  const setIsConnected = useCallback((connected: boolean) => {
    setIsConnectedState(connected);
    if (!connected) {
      setUserDataState(null); // Clear user data if disconnected
    }
  }, []);

  // Helper to check if user has ETH connection
  const hasEthConnection = !!userData?.ethPublicAddress;

  // Helper to check if user has Stellar connection
  const hasStellarConnection = !!userData?.stellarPublicAddress;

  // Update ETH connection while preserving other data
  const updateEthConnection = useCallback(
    (ethPublicAddress: string, ethPrivateAddress: string = "") => {
      setUserDataState((prevData) => ({
        email: prevData?.email || "",
        ethPublicAddress,
        ethPrivateAddress,
        stellarPublicAddress: prevData?.stellarPublicAddress || "",
        stellarPrivateAddress: prevData?.stellarPrivateAddress || "",
      }));
      setIsConnectedState(true);
    },
    []
  );

  // Update Stellar connection while preserving other data
  const updateStellarConnection = useCallback(
    (stellarPublicAddress: string, stellarPrivateAddress: string = "") => {
      setUserDataState((prevData) => ({
        email: prevData?.email || "",
        ethPublicAddress: prevData?.ethPublicAddress || "",
        ethPrivateAddress: prevData?.ethPrivateAddress || "",
        stellarPublicAddress,
        stellarPrivateAddress,
      }));
      setIsConnectedState(true);
    },
    []
  );

  return (
    <UserContext.Provider
      value={{
        userData,
        setUserData,
        isConnected,
        setIsConnected,
        hasEthConnection,
        hasStellarConnection,
        updateEthConnection,
        updateStellarConnection,
      }}
    >
      {children}
    </UserContext.Provider>
  );
}

export function useUser() {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error("useUser must be used within a UserProvider");
  }
  return context;
}

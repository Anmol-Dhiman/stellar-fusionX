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

  return (
    <UserContext.Provider
      value={{ userData, setUserData, isConnected, setIsConnected }}
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

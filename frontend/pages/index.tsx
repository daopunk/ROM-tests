/* eslint-disable react-hooks/exhaustive-deps */
import React, { useContext, ReactNode } from "react";
import { Flex } from "@raidguild/design-system";
import { useAccount } from "wagmi";
import { UserContext } from "context/UserContext";
import { useGetDeadline } from "hooks/useGetDeadline";
import { useRiteBalanceOf } from "hooks/useRiteBalanceOf";
import useIsMember from "hooks/useIsMember";
import BoxHeader from "components/BoxHeader";
import HeaderOne from "../components/Header0ne";
import RiteStaked from "components/RiteStaked";
import StakingFlow from "components/StakingFlow";

interface HomeProps {
  children: ReactNode;
}

const Home: React.FC<HomeProps> = ({ children }): any => {
  const { willSponsor } = useContext(UserContext);
  const { address, isConnected } = useAccount();

  function userAddress(): string {
    if (typeof address === "string") return address;
    else return "";
  }

  const deadline: string = useGetDeadline([userAddress()]);

  const riteBalance: string = useRiteBalanceOf([userAddress()]);

  const isMember: boolean = useIsMember([userAddress()]);
  console.log("isMember", isMember, typeof isMember);

  return (
    <Flex
      minH="350px"
      minW="80%"
      direction="column"
      alignItems="center"
      fontFamily="spaceMono"
      px="2rem"
    >
      <HeaderOne />
      {!isConnected && (
        <BoxHeader text="Connect your wallet and stake to our cohort!" />
      )}
      {isConnected && <BoxHeader text="Join our cohort!" />}

      {/* RiteStaked shown if user has already staked, but wants to sponsor another address. RiteStaked also renders StakingFlow */}

      {isConnected && isMember ? (
        <RiteStaked riteBalance={riteBalance} deadline={deadline} />
      ) : null}
      {isConnected && !isMember ? <StakingFlow /> : null}
    </Flex>
  );
};

export default Home;

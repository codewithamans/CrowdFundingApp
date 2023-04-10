import { useState, useEffect } from "react";
import { crowdFundingAddress, crowdFundingABI } from "./constants";
import { ethers } from "ethers";
import Web3modal from "web3modal";

const fetchContract = (provider) => {
  new ethers.Contract(crowdFundingAddress, crowdFundingABI, provider);
};

export const crowdFundingContext = React.createContext();

export const crowdFundingProvider = ({ children }) => {
  const title = "Crowd Funding Contract";
  const [currentAccount, setcurrenAccount] = useState("");

  const createCampaign = async (Campaign) => {
    const { title, description, amount, deadline } = Campaign;
    const web3 = new Web3modal();
    const connection = await web3.connect();
    const provider = new ethers.providers.Web3Provider(connection);
    const signer = provider.getSigner();
    const contract = fetchContract(signer);

    try {
      const transaction = await contract.createCampaign(
        currentAccount,
        title,
        description,
        ethers.utils.parseUnits(amount, 18),
        new Date(deadline).getTime()
      );
      await transaction.wait();
      console.log("Success !!!!", transaction);
    } catch (error) {
      console.log("Failure : ", error);
    }
  };
};

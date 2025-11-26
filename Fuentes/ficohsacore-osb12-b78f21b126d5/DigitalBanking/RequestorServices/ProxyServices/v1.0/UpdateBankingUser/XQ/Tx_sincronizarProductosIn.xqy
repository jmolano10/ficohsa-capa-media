xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/createBankingUser";
(:: import schema at "../../../../../../MWBanking/Users/RequestorServices/XSD/createBankingUser.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.sites";
declare variable $udpateBankingUser as element() (:: schema-element(ns1:updateBankingUserRequest) ::) external;

declare function xq:Tx_sincronizarProductosIn($udpateBankingUser as element() (:: schema-element(ns1:updateBankingUserRequest) ::))
as element(*) {
        <ns3:SynchronizeNewSiteProductsOnDemandMessageIn>
			<ns3:DocumentNumber>{ data($udpateBankingUser/*:UserName) }</ns3:DocumentNumber>
      	</ns3:SynchronizeNewSiteProductsOnDemandMessageIn>
};

xq:Tx_sincronizarProductosIn($udpateBankingUser)

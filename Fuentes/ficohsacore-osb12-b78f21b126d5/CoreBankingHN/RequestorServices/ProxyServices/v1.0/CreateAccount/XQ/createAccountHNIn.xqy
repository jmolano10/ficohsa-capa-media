xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CreateAccount/CreateAccount_BS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createAccountHNIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $createAccountRequest as element() (:: schema-element(ns2:createAccountRequest) ::) external;(: Función encargada de realizar el mapeo de usuario:)

declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function ns1:createAccountHNIn($userName as xs:string, 
                                       $password as xs:string, 
                                       $createAccountRequest as element() (:: schema-element(ns2:createAccountRequest) ::)) 
                                       as element() (:: schema-element(ns3:AperturaCuentasCliente) ::) {
    <ns3:AperturaCuentasCliente>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <gtsControl></gtsControl>
            <messageId></messageId>
            <noOfAuth></noOfAuth>
            <replace></replace>
        </OfsFunction>
        <FICOBULKAPPRCLNTINPUTPRODUCTWSType>
            {
                if ($createAccountRequest/ns2:ProcessType)
                then <PROCESSTYPE>{fn:data($createAccountRequest/ns2:ProcessType)}</PROCESSTYPE>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:Category)
                then <CATEGORY>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:Category)}</CATEGORY>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:Currency)
                then <CURRENCY>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:Currency)}</CURRENCY>
                else ()
            }
            {
                if ($createAccountRequest/ns2:CustomerCode)
                then <CUSTOMER>{fn:data($createAccountRequest/ns2:CustomerCode)}</CUSTOMER>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:ReferredType)
                then <REFEREDTYPE>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:ReferredType)}</REFEREDTYPE>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:Passbook)
                then <PASSBOOK>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:Passbook)}</PASSBOOK>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:PassbookNumber)
                then <PASSBOOKNUMBER>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:PassbookNumber)}</PASSBOOKNUMBER>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:PayrollGroup)
                then <LRPAYROLLGRP>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:PayrollGroup)}</LRPAYROLLGRP>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:InitialDeposit)
                then <INITIALDEPOSIT>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:InitialDeposit)}</INITIALDEPOSIT>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:Purpose)
                then <LRPURPOSE>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:Purpose)}</LRPURPOSE>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:OrigenOfFunds)
                then <LRORGOFFUNDS>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:OrigenOfFunds)}</LRORGOFFUNDS>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:MonthlyTxnVolume)
                then <LRMONTXVOL>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:MonthlyTxnVolume)}</LRMONTXVOL>
                else ()
            }
            {
                if ($createAccountRequest/ns2:AccountDetail/ns2:AddressType)
                then <ADDRESSTYPE>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:AddressType)}</ADDRESSTYPE>
                else ()
            }
            {
                if ($createAccountRequest/ns2:SignatoryDetails/ns2:RegisteredSignatory)
                then <REGISTEREDSIGN>{fn:data($createAccountRequest/ns2:SignatoryDetails/ns2:RegisteredSignatory)}</REGISTEREDSIGN>
                else ()
            }
            {
                if ($createAccountRequest/ns2:SignatoryDetails/ns2:RequiredSignatory)
                then <REQUIREDSIGN>{fn:data($createAccountRequest/ns2:SignatoryDetails/ns2:RequiredSignatory)}</REQUIREDSIGN>
                else ()
            }
            {
                if ($createAccountRequest/ns2:SignatoryDetails/ns2:SignatoryDescription)
                then <LRADDDESC>{fn:data($createAccountRequest/ns2:SignatoryDetails/ns2:SignatoryDescription)}</LRADDDESC>
                else ()
            }
            <MODOFDEPOSIT></MODOFDEPOSIT>
            {
                if ($createAccountRequest/ns2:CardInformation/ns2:CardNumber)
                then <TDCODID>{fn:data($createAccountRequest/ns2:CardInformation/ns2:CardNumber)}</TDCODID>
                else ()
            }
            {
                if ($createAccountRequest/ns2:CardInformation/ns2:PrimaryAccount)
                then <PRIMARYACCT>{fn:data($createAccountRequest/ns2:CardInformation/ns2:PrimaryAccount)}</PRIMARYACCT>
                else ()
            }
            {
                if ($createAccountRequest/ns2:CardInformation/ns2:DeliveryBranch)
                then <TOAGENCY>{fn:data($createAccountRequest/ns2:CardInformation/ns2:DeliveryBranch)}</TOAGENCY>
                else ()
            }
            {
                if ($createAccountRequest/ns2:CardInformation/ns2:EmissionPay)
                then <LRREEMISIONTD>{fn:data($createAccountRequest/ns2:CardInformation/ns2:EmissionPay)}</LRREEMISIONTD>
                else ()
            }
            <gFIELDS81 g="1">
                <LROPRTTYPE>{fn:data($createAccountRequest/ns2:AccountDetail/ns2:OperationType)}</LROPRTTYPE>
            </gFIELDS81>
            {
                let $BENEFICIARY_DETAIL := $createAccountRequest/ns2:BeneficiaryDetails/ns2:BeneficiaryDetail
                let $count := count($BENEFICIARY_DETAIL)
                return (
                    <gFIELDS86 g="{$count}">
                	{
                		for $NAMES in $BENEFICIARY_DETAIL
                		return
                        	<LRBENNAME>{ data($NAMES/ns2:BeneficiaryName) }</LRBENNAME>
                	}
                	</gFIELDS86>,
                	<gFIELDS87 g="{$count}">
                	{
                		for $RELATION in $BENEFICIARY_DETAIL
                		return
                     		<LRBENRELN>{ data($RELATION/ns2:Relation) }</LRBENRELN>
                	}
                	</gFIELDS87>,
                	<gFIELDS88 g="{$count}">
                	{
                		for $RELATION in $BENEFICIARY_DETAIL
                		return
                     		<LRBENPRG>{ data($RELATION/ns2:BeneficiaryPercentage) }</LRBENPRG>
                	}
                	</gFIELDS88>,
                	 <gFIELDS89 g="{$count}">
                    {
                        for $DOCUMENT_TYPE in $BENEFICIARY_DETAIL
                        return
                            <LRTINACT>{ data($DOCUMENT_TYPE/ns2:DocumentType) }</LRTINACT>
                    }
                	</gFIELDS89>,
                	<gFIELDS90>
                    {
                        for $PRIMARY_ACCOUNT in $BENEFICIARY_DETAIL
                    	return
                            <LRNUMACT>{ data($PRIMARY_ACCOUNT/ns2:LegalId) }</LRNUMACT>
                    }
                	</gFIELDS90>,
                	<gFIELDS91 g="{$count}">
                	{
                		for $DOCUMENT_TYPE in $BENEFICIARY_DETAIL
                		return
                    		<LRBENIDTYPE>{ data($DOCUMENT_TYPE/ns2:DocumentType) }</LRBENIDTYPE>
                    }
                    </gFIELDS91>
                )
            }
            {
                if ($createAccountRequest/ns2:InterfaceUser)
                then <USERID>{fn:data($createAccountRequest/ns2:InterfaceUser)}</USERID>
                else ()
            }
        </FICOBULKAPPRCLNTINPUTPRODUCTWSType>
    </ns3:AperturaCuentasCliente>
};

ns1:createAccountHNIn($userName, $password, $createAccountRequest)

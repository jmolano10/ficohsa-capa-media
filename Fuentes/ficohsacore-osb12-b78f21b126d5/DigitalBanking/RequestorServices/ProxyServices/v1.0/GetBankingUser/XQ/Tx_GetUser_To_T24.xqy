xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../../CoreBankingHN/ProviderServices/XSD/GetUser/v1.0/Core.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/MWBanking/GetUser_PS";
(:: import schema at "../WSDL/GetUserHN_PS.wsdl" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $getUser as element() (:: schema-element(ns1:getUser_params) ::) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
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

declare function xq:Tx_GetUser_To_T24($userName as xs:string,$password as xs:string,$getUser as element() (:: schema-element(ns1:getUser_params) ::)) as element() (:: schema-element(ns2:Consultadeusuariosdelsistema) ::) {
    <ns2:Consultadeusuariosdelsistema>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
          <WSUSERType>
           	{
           		let $USER_ID := fn:string($getUser/USER_ID/text())
           		return 
           			if ($USER_ID != "") then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ $USER_ID }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $BRANCH_CODE := fn:string($getUser/BRANCH_CODE/text())
           		return 
           			if ($BRANCH_CODE != "") then (
		                <enquiryInputCollection>
		                    <columnName>LR.AGENCY.CODE</columnName>
		                    <criteriaValue>{ $BRANCH_CODE }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $APPLICATION := fn:string($getUser/APPLICATION/text())
           		return 
           			if ($APPLICATION != "") then (
		                <enquiryInputCollection>
		                    <columnName>APPLICATION</columnName>
		                    <criteriaValue>{ $APPLICATION }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
           	{
           		let $SIGN_ON_NAME := fn:string($getUser/SIGN_ON_NAME/text())
           		return 
           			if ($SIGN_ON_NAME != "") then (
		                <enquiryInputCollection>
		                    <columnName>SIGN.ON.NAME</columnName>
		                    <criteriaValue>{ $SIGN_ON_NAME }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }	 
	               	        	                   	{
           		let $OFFICER_DAO := fn:string($getUser/OFFICER_DAO/text())
           		return 
           			if ($OFFICER_DAO != "") then (
		                <enquiryInputCollection>
		                    <columnName>LR.OFFICER.DAO</columnName>
		                    <criteriaValue>{ $OFFICER_DAO }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }	
            </WSUSERType>
      </ns2:Consultadeusuariosdelsistema>
};

xq:Tx_GetUser_To_T24($userName,$password,$getUser)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaTransaccionBancaria1" element="ns1:creaTransaccionBancaria" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreatransaccionACH" location="../../../BusinessServices/T24/CreaTransaccionBancariaACH/xsd/creaTransaccionBancariaACH.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBancariasIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:creaTransaccionBancariasIn($requestHeader1 as element(ns2:RequestHeader),
    $creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria))
    as element(ns0:CreatransaccionACH) {
        <ns0:CreatransaccionACH>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl/>
	            <messageId/>
	            <noOfAuth/>
	            <replace/>
            </OfsFunction>
            <FICOHNACHONLINESENDCREDITType>
                <DEBITACCTNO>{ data($creaTransaccionBancaria1/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <CREDITACCTNO>{ data($creaTransaccionBancaria1/CREDIT_ACCOUNT) }</CREDITACCTNO>
                <CREDITCCY>{ data($creaTransaccionBancaria1/CURRENCY) }</CREDITCCY>
                <AMOUNT>{ data($creaTransaccionBancaria1/TRANSFER_AMOUNT) }</AMOUNT>
                <GLOBALREFERENCE>{ data($creaTransaccionBancaria1/GLOBAL_REFERENCE) }</GLOBALREFERENCE>
                <IDBANKISSUER>{ data($creaTransaccionBancaria1/BANK_ID) }</IDBANKISSUER>
                <LEGENDBANKISSUER>{ data($creaTransaccionBancaria1/REFERENCE_NUMBER) }</LEGENDBANKISSUER>
                <IDPRODUCT>{ data($creaTransaccionBancaria1/CREDIT_ACCOUNT_TYPE) }</IDPRODUCT>
                <TIPOTRANS>{ data($creaTransaccionBancaria1/TRANSACTION_TYPE) }</TIPOTRANS>
                <DESTCUSTOMERID>{ data($creaTransaccionBancaria1/BENEFICIARY_ID) }</DESTCUSTOMERID>
                <NARADDEND>{ data($creaTransaccionBancaria1/DESCRIPTION) }</NARADDEND>
                <CUSNAME>{ fn:substring(data($creaTransaccionBancaria1/BENEFICIARY_NAME), 1 , 60) }</CUSNAME>
                <ACHTXNTYPE>{ data($creaTransaccionBancaria1/TRANSFER_TYPE) }</ACHTXNTYPE>
                <TICKET>{ data($creaTransaccionBancaria1/TICKET) }</TICKET>
                <LRIDPIISSUER>{ data($creaTransaccionBancaria1/ID_INDIRECT_PARTICIPANT) }</LRIDPIISSUER>
                <LRIDPIRECIEV>{ data($creaTransaccionBancaria1/ID_INDIRECT_PARTICIPANT_RECEIVER) }</LRIDPIRECIEV>
                <LRBENNAME>{ fn:substring(data($creaTransaccionBancaria1/ORIGINATOR_NAME),1, 60) }</LRBENNAME>
                <LRIDQR>{ data($creaTransaccionBancaria1/ID_QR) }</LRIDQR>
                <LRDESCUSTID2>{ data($creaTransaccionBancaria1/REMITTANCE_ID) }</LRDESCUSTID2>
            </FICOHNACHONLINESENDCREDITType>
        </ns0:CreatransaccionACH>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria) external;

xf:creaTransaccionBancariasIn($requestHeader1,
    $creaTransaccionBancaria1)
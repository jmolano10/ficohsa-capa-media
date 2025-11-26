(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$simulaPagoChequeCompensacion1" element="ns1:simulaPagoChequeCompensacion" location="simulaPagoChequeCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Simulapagodechqporcompensacion" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/simulaPagoChequeCompensacion/simulaPagoChequeCompensacionIn/";

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

declare function xf:simulaPagoChequeCompensacionIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $simulaPagoChequeCompensacion1 as element(ns1:simulaPagoChequeCompensacion))
    as element(ns0:Simulapagodechqporcompensacion) {
        <ns0:Simulapagodechqporcompensacion>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            {
                let $simulaPagoChequeCompensacion := $simulaPagoChequeCompensacion1
                return
                    <FICOINWARDCLEARINGPREVALIDATEType id = "">
                        <ROUTECODE>{ data($simulaPagoChequeCompensacion/ROUTE_CODE) }</ROUTECODE>
                        <CLGACCOUNTNUMBER>{ data($simulaPagoChequeCompensacion/ACCOUNT_NUMBER) }</CLGACCOUNTNUMBER>
                        <CHEQUENUMBER>{ data($simulaPagoChequeCompensacion/CHEQUE_NUMBER) }</CHEQUENUMBER>
                        <CHEQUECCY>{ data($simulaPagoChequeCompensacion/CURRENCY) }</CHEQUECCY>
                        <CHEQUEAMOUNT>{ data($simulaPagoChequeCompensacion/AMOUNT) }</CHEQUEAMOUNT>
                        <CLRINGCENTRCODE>{ data($simulaPagoChequeCompensacion/COST_CENTER_CODE) }</CLRINGCENTRCODE>
                    </FICOINWARDCLEARINGPREVALIDATEType>
            }
        </ns0:Simulapagodechqporcompensacion>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $simulaPagoChequeCompensacion1 as element(ns1:simulaPagoChequeCompensacion) external;

xf:simulaPagoChequeCompensacionIn($autenticacionRequestHeader1,
    $simulaPagoChequeCompensacion1)
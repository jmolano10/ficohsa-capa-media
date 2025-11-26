(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoChequeCompensacion1" element="ns2:pagoChequeCompensacion" location="pagoChequeCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagodechqporcompensacion" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCompensacionTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/pagoChequeCompensacion/pagoChequeCompensacionIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoChequeCompensacionIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $pagoChequeCompensacion1 as element(ns2:pagoChequeCompensacion))
    as element(ns0:Pagodechqporcompensacion) {
        <ns0:Pagodechqporcompensacion>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl>0</gtsControl>
            </OfsFunction>
            {
                let $pagoChequeCompensacion := $pagoChequeCompensacion1
                return
                    <FICOINWARDCLEARINGDEBITCHQINWARDCLGType id = "">
                        <ROUTECODE>{ data($pagoChequeCompensacion/ROUTE_CODE) }</ROUTECODE>
                        <CLGACCOUNTNUMBER>{ data($pagoChequeCompensacion/ACCOUNT_NUMBER) }</CLGACCOUNTNUMBER>
                        <CHEQUENUMBER>{ data($pagoChequeCompensacion/CHEQUE_NUMBER) }</CHEQUENUMBER>
                        <CHEQUECCY>{ data($pagoChequeCompensacion/CURRENCY) }</CHEQUECCY>
                        <CHEQUEAMOUNT>{ data($pagoChequeCompensacion/AMOUNT) }</CHEQUEAMOUNT>
                        <CLRINGCENTRCODE>{ data($pagoChequeCompensacion/COST_CENTRE_CODE) }</CLRINGCENTRCODE>
                    </FICOINWARDCLEARINGDEBITCHQINWARDCLGType>
            }
        </ns0:Pagodechqporcompensacion>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $pagoChequeCompensacion1 as element(ns2:pagoChequeCompensacion) external;

xf:pagoChequeCompensacionIn($autenticacionRequestHeader1,
    $pagoChequeCompensacion1)
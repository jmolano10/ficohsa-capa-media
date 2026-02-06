xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultaDetalleCuenta" location="../../../BusinessServices/ConsultaDetallesCuentaMasivos/xsd/services_1.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuentaMasivos/xq/ConsultaDetalleCuentaIn/";

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

declare function xf:ConsultaDetalleCuentaIn($accountNumber as xs:string,
    $userName as xs:string)
    as element(ns0:ConsultaDetalleCuenta) {
        <ns0:ConsultaDetalleCuenta>
            <WebRequestCommon>
                <userName>
                {
                	fn-bea:fail-over( getUsername($userName),
                        $userName)
                }
                </userName>
                <password>
                {
                	fn-bea:fail-over( getPassword($userName),
                        $userName)
                }
                </password>
            </WebRequestCommon>
            <WSFICOACCTDETMASSIVEINTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $accountNumber }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOACCTDETMASSIVEINTType>
        </ns0:ConsultaDetalleCuenta>
};

declare variable $accountNumber as xs:string external;
declare variable $userName as xs:string external;

xf:ConsultaDetalleCuentaIn($accountNumber,
    $userName)
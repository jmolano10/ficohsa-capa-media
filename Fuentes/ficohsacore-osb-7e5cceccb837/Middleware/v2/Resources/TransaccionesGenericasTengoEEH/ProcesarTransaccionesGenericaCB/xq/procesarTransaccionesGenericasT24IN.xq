(:: pragma bea:global-element-parameter parameter="$procesaTransaccionesGenericasRequest1" element="ns1:procesaTransaccionesGenericasRequest" location="../xsd/procesaTransaccionesGenericasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistrarTransaccionesTENGOEEH" location="../../../../BusinessServices/T24/svcGestionesTrxSEEHTENGO/xsd/svcGestionesTrxSEEHTENGOTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaTransaccionesGenericasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasTengoEEH/ProcesarTransaccionesGenericaCB/xq/procesarTransaccionesGenericasT24IN/";

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


declare function xf:procesarTransaccionesGenericasT24IN($procesaTransaccionesGenericasRequest1 as element(ns1:procesaTransaccionesGenericasRequest),
    $CUENTADEBITO as xs:string,
    $UUID as xs:string,
    $IDCONVENIO as xs:string,
    $USER as xs:string,
    $PASSWORD as xs:string)
    as element(ns0:RegistrarTransaccionesTENGOEEH) {
        <ns0:RegistrarTransaccionesTENGOEEH>
           <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername($USER),$USER)
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($USER),$PASSWORD)
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                   <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERTENGOEEHType>
                <DEBITACCTNO>{ $CUENTADEBITO }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($procesaTransaccionesGenericasRequest1/MONEDA) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($procesaTransaccionesGenericasRequest1/MONTO_TRX) }</DEBITAMOUNT>
                <LRAGRCLIENT>{ $IDCONVENIO }</LRAGRCLIENT>
                <LRREFTENGO>{ $UUID }</LRREFTENGO>
            </FUNDSTRANSFERTENGOEEHType>
        </ns0:RegistrarTransaccionesTENGOEEH>
};

declare variable $procesaTransaccionesGenericasRequest1 as element(ns1:procesaTransaccionesGenericasRequest) external;
declare variable $CUENTADEBITO as xs:string external;
declare variable $UUID as xs:string external;
declare variable $IDCONVENIO as xs:string external;
declare variable $USER as xs:string external;
declare variable $PASSWORD as xs:string external;

xf:procesarTransaccionesGenericasT24IN($procesaTransaccionesGenericasRequest1,
    $CUENTADEBITO,
    $UUID,
    $IDCONVENIO,
    $USER,
    $PASSWORD)
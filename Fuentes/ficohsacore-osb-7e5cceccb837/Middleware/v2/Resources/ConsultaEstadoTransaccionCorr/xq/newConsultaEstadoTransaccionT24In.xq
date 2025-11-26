(:: pragma bea:global-element-return element="ns0:ConsultaEstadoTransaccion" location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/newConsultaEstadoTransaccionT24In/";

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

declare function xf:newConsultaEstadoTransaccionT24In($UUID as xs:string,
    $user as xs:string,
    $pass as xs:string)
    as element(ns0:ConsultaEstadoTransaccion) {
        <ns0:ConsultaEstadoTransaccion>
         <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername($user),$user)
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($user),$pass)
                    }
				</password>
            </WebRequestCommon>
            <WSFICOCONSULTATRXTENGOType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $UUID }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOCONSULTATRXTENGOType>
        </ns0:ConsultaEstadoTransaccion>
};

declare variable $UUID as xs:string external;
declare variable $user as xs:string external;
declare variable $pass as xs:string external;

xf:newConsultaEstadoTransaccionT24In($UUID,
    $user,
    $pass)

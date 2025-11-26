(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosMultipleProductos" element="ns1:sjConsultaSaldosMultipleProductos" location="../xsd/sjConsultaSaldosMultipleProductos.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMultipleProducto" location="../../../ConsultaMultipleProducto/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosMultipleProductos";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosMultipleProductos/xq/consultaMultipleProductoIn/";

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

declare function xf:consultaMultipleProductoIn($sjConsultaSaldosMultipleProductos as element(ns1:sjConsultaSaldosMultipleProductos))
    as element(ns0:ConsultaMultipleProducto) {
        <ns0:ConsultaMultipleProducto>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername(data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)), data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($sjConsultaSaldosMultipleProductos/ns1:USERNAME)), data($sjConsultaSaldosMultipleProductos/ns1:PASSWORD)) }</password>
            </WebRequestCommon>
            <WSFICOACCTDETMULTPRODType>
                {
                    for $ID in $sjConsultaSaldosMultipleProductos/ns1:PRODUCTS/ns1:ID
                    return
                        <enquiryInputCollection>
                            <columnName>@ID</columnName>
                            <criteriaValue>{ data($ID) }</criteriaValue>
                            <operand>EQ</operand>
                        </enquiryInputCollection>
                }
            </WSFICOACCTDETMULTPRODType>
        </ns0:ConsultaMultipleProducto>
};

declare variable $sjConsultaSaldosMultipleProductos as element(ns1:sjConsultaSaldosMultipleProductos) external;

xf:consultaMultipleProductoIn($sjConsultaSaldosMultipleProductos)

xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaProductosResponse/ns1:PRODUCTS/ns1:PRODUCT" location="../xsd/sjConsultaProductos.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaProductos";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaProductos/xq/sjConsultaCuentasOut/";

declare function xf:sjConsultaCuentasOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse),
	$accountNumber as xs:string)
    as element() {
        <ns1:PRODUCT>
  			<ns1:TYPE>CTA</ns1:TYPE>
        	<ns1:ID>{ $accountNumber }</ns1:ID>
            {
            
            
            	if (data($consultadedetallesdelacuentaResponse1/Status/successIndicator) = "Success") then (
            		if (fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/ZERORECORDS/text()) = "") then (
            			<ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>,
            			<ns1:MESSAGE/>,
            			<ns1:ALT_ID>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/ALTACCTID) }</ns1:ALT_ID>,
            			<ns1:NAME>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/SHORTTITLE) }</ns1:NAME>,
            			<ns1:CURRENCY>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/CURRENCY) }</ns1:CURRENCY>,
            			<ns1:STATUS>
            			{ 
            				if (data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/INACTIVEMARKER) = "Y") then (
            				"INACTIVE"
            				) else if (data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/POSTINGRESTRICT) != "") then (
            					data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType[1]/mWSACCOUNTLISTDetailType[1]/POSTINGRESTRICT)
            				) else (
            					"ACTIVE"
            				)
            				  
            			}
            			</ns1:STATUS>
            		) else (
            			<ns1:SUCCESS_INDICATOR>NO RECORDS</ns1:SUCCESS_INDICATOR>,
            			<ns1:MESSAGE>{ fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/ZERORECORDS/text()) }</ns1:MESSAGE>
            		)  
            	) else 
            	(
            		<ns1:SUCCESS_INDICATOR>ERROR</ns1:SUCCESS_INDICATOR>,
            		<ns1:MESSAGE>{ fn:string-join($consultadedetallesdelacuentaResponse1/Status/messages/text(),"") }</ns1:MESSAGE>
            	)
            }
        </ns1:PRODUCT>
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $accountNumber as xs:string external;

xf:sjConsultaCuentasOut($consultadedetallesdelacuentaResponse1,
	$accountNumber)
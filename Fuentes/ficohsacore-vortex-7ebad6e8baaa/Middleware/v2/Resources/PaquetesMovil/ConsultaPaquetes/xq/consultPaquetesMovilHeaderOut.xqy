xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilesResponse" element="ns1:ConsultaPaquetesMovilesResponse" location="../../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMovil/ConsultaPaquetes/xq/consultPaquetesMovilHeaderOut/";

declare function xf:consultPaquetesMovilHeaderOut($consultaPaquetesMovilesResponse as element(ns1:ConsultaPaquetesMovilesResponse),
    $packType as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                let $conteo :=  count($consultaPaquetesMovilesResponse/WSFICOPARAMPACKAGEType[1]/gWSFICOPARAMPACKAGEDetailType/mWSFICOPARAMPACKAGEDetailType[PACKTYPE/text() = $packType])
                let $successIndicator := fn:string($consultaPaquetesMovilesResponse/Status/successIndicator/text())
                return
                	if($successIndicator = "Success" and $conteo = 0 and $packType != "") then (
                		<successIndicator>NO RECORDS</successIndicator>
                	) else (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    )
            }
            {
                for $messages in $consultaPaquetesMovilesResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $consultaPaquetesMovilesResponse as element(ns1:ConsultaPaquetesMovilesResponse) external;
declare variable $packType as xs:string external;

xf:consultPaquetesMovilHeaderOut($consultaPaquetesMovilesResponse,
    $packType)
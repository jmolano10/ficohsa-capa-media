xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjetaResponse" element="ns1:sjConsultaTipoTarjetaResponse" location="../../../BusinessServices/SJS/consultaTipoTarjetaNI/xsd/sjConsultaTipoTarjetaNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PointsRedeemRequest" location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjetaNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemNIIn/";

declare function xf:pointsRedeemNIIn($sjConsultaTipoTarjetaResponse as element(ns1:sjConsultaTipoTarjetaResponse),
    $rewardItemParameter as xs:string,
    $pointsParameter as xs:string)
    as element(ns0:PointsRedeemRequest) {
        <ns0:PointsRedeemRequest>
            <GPXRAI-ORG>{ data($sjConsultaTipoTarjetaResponse/ns1:ORG) }</GPXRAI-ORG>
            <GPXRAI-CARD-NBR>0</GPXRAI-CARD-NBR>
            <GPXRAI-ACCT-NBR>{ data($sjConsultaTipoTarjetaResponse/ns1:ACCOUNT_NUMBER) }</GPXRAI-ACCT-NBR>
            <GPXRAI-SCHEME-ID>{ data($sjConsultaTipoTarjetaResponse/ns1:SCHEME) }</GPXRAI-SCHEME-ID>
        	<GPXRAI-REWARD-ITEM>{$rewardItemParameter}</GPXRAI-REWARD-ITEM>
        	<GPXRAI-PREPAID-CARD-NBR/>           					
			<GPXRAI-POINTS>{xs:decimal($pointsParameter) * 1000}</GPXRAI-POINTS>
			<GPXRAI-REASON-CODE>01</GPXRAI-REASON-CODE>
			<GPXRAI-USER-DATA>EM</GPXRAI-USER-DATA>
			<CuponArray>
    			<CuponElement>
        			<GPXRAI-COUPON-DENOM>0</GPXRAI-COUPON-DENOM>
        			<GPXRAI-COUPON-NBR>0</GPXRAI-COUPON-NBR>
    			</CuponElement>
			</CuponArray>
			<GPXRAI-NAME-1/>
			<GPXRAI-NAME-2/>
        </ns0:PointsRedeemRequest>
};

declare variable $sjConsultaTipoTarjetaResponse as element(ns1:sjConsultaTipoTarjetaResponse) external;
declare variable $rewardItemParameter as xs:string external;
declare variable $pointsParameter as xs:string external;

xf:pointsRedeemNIIn($sjConsultaTipoTarjetaResponse,
    $rewardItemParameter,
    $pointsParameter)
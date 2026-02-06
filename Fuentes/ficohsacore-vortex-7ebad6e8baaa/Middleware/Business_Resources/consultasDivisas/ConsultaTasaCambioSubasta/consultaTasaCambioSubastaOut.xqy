xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiosubastaResponse" element="ns1:ConsultadetasadecambiosubastaResponse" location="../Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioSubastaResponse" location="consultaTasaCambioSubastaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioSubastaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasDivisas/ConsultaTasaCambioSubasta/consultaTasaCambioSubastaOut/";

declare function xf:consultaTasaCambioSubastaOut($consultadetasadecambiosubastaResponse as element(ns1:ConsultadetasadecambiosubastaResponse))
    as element(ns0:consultaTasaCambioSubastaResponse) {
        <ns0:consultaTasaCambioSubastaResponse>
            {
                for $MAXIMUMRATE in $consultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/MAXIMUMRATE
                return
                    <MAX_AUCTION_RATE>{ data($MAXIMUMRATE) }</MAX_AUCTION_RATE>
            }
            {
                for $MINIMUMRATE in $consultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/MINIMUMRATE
                return
                    <MIN_AUCTION_RATE>{ data($MINIMUMRATE) }</MIN_AUCTION_RATE>
            }
            {
                for $AVERAGERATE in $consultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/AVERAGERATE
                return
                    <AVG_AUCTION_RATE>{ data($AVERAGERATE) }</AVG_AUCTION_RATE>
            }
        </ns0:consultaTasaCambioSubastaResponse>
};

declare variable $consultadetasadecambiosubastaResponse as element(ns1:ConsultadetasadecambiosubastaResponse) external;

xf:consultaTasaCambioSubastaOut($consultadetasadecambiosubastaResponse)
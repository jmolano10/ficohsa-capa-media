(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../xsd/Header.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../../Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/General/xq/mwCajaHeaderToMiddlewareRGHeader/";

declare function xf:mwCajaHeaderToMiddlewareRGHeader($requestHeader as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($requestHeader/AUTHENTICATION/USERNAME) }</UserName>
                <Password>{ data($requestHeader/AUTHENTICATION/PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader/REGION/SOURCE_BANK) }</SourceBank>
                {
                    for $DESTINATION_BANK in $requestHeader/REGION/DESTINATION_BANK
                    return
                        <DestinationBank>{ data($DESTINATION_BANK) }</DestinationBank>
                }
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:mwCajaHeaderToMiddlewareRGHeader($requestHeader)

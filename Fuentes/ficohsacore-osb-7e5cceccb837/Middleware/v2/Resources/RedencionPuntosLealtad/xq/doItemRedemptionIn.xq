(:: pragma bea:global-element-return element="ns0:doItemRedemption" location="../../../BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd" ::)

declare namespace ns0 = "http://redemption.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/doItemRedemptionIn/";

declare function xf:doItemRedemptionIn($cantidad as xs:long, $matrixId as xs:string)
    as element(ns0:doItemRedemption) {
        <ns0:doItemRedemption>
            <ns0:confirmationEmailSw>false</ns0:confirmationEmailSw>
            <ns0:confirmationEmailAddr>info@ficohsa.com</ns0:confirmationEmailAddr>
            <ns0:redemptions>
                <ns0:rewardMatrixItemId>{ $matrixId }</ns0:rewardMatrixItemId>
                <ns0:quantity>{ $cantidad }</ns0:quantity>
                <ns0:newShippingAddressSw>true</ns0:newShippingAddressSw>
                <ns0:shippingAddress>
                    <ns0:poBoxAddressSw>false</ns0:poBoxAddressSw>
                </ns0:shippingAddress>
            </ns0:redemptions>
            <ns0:language>en_US</ns0:language>
        </ns0:doItemRedemption>
};

declare variable $cantidad as xs:long external;
declare variable $matrixId as xs:string external;

xf:doItemRedemptionIn($cantidad, $matrixId)
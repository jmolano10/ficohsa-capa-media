(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaBin/xsd/consultaBin_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaBINResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBin";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBIN/xq/consultaBinGTOut/";

declare function xf:consultaBinGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaBINResponse) {
        <ns0:consultaBINResponse>
            {
                <BIN_DETAILS>
                    {
                        for $PV_BIN_DETAILS_ITEM in $outputParameters/ns1:PV_BIN_DETAILS/ns1:PV_BIN_DETAILS_ITEM
                        return
                            <BIN_ITEM>
                                <BIN>{ data($PV_BIN_DETAILS_ITEM/ns1:BIN) }</BIN>
                                <COMPANY>{ data($PV_BIN_DETAILS_ITEM/ns1:COMPANY) }</COMPANY>
                                <PRODUCT_DESCRIPTION>{ data($PV_BIN_DETAILS_ITEM/ns1:PRODUCT_DESCRIPTION) }</PRODUCT_DESCRIPTION>
                                <CREATION_DATE>{ data($PV_BIN_DETAILS_ITEM/ns1:CREATION_DATE) }</CREATION_DATE>
                                <STATUS>{ data($PV_BIN_DETAILS_ITEM/ns1:BANK_STATUS) }</STATUS>
                            </BIN_ITEM>
                    }
                </BIN_DETAILS>
            }
        </ns0:consultaBINResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaBinGTOut($outputParameters)

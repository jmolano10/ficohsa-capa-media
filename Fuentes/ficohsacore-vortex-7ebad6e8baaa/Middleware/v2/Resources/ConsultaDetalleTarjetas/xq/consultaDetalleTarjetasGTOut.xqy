xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleTarjetas/xsd/consultaDetalleTarjetas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleTarjetasResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTarjetas/xq/consultaDetalleTarjetasGTOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleTarjetas";

declare function xf:consultaDetalleTarjetasGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaDetalleTarjetasResponse) {
        <ns0:consultaDetalleTarjetasResponse>
        	<CARD_DETAILS>
                {
                    for $PV_CARD_DETAILS_ITEM in $outputParameters/ns1:PV_CARD_DETAILS/ns1:PV_CARD_DETAILS_ITEM
                    return
                    	(
	                    	if(fn:string($PV_CARD_DETAILS_ITEM/ns1:BIN/text()) != '') then(
	                    		<CARD_ITEM>
		                            <BIN>{ data($PV_CARD_DETAILS_ITEM/ns1:BIN) }</BIN>
		                            <COMPANY>{ data($PV_CARD_DETAILS_ITEM/ns1:COMPANY) }</COMPANY>
		                            <CARD_NUMBER>{ data($PV_CARD_DETAILS_ITEM/ns1:CARD_NUMBER) }</CARD_NUMBER>
		                            <CUSTOMER_ID>{ data($PV_CARD_DETAILS_ITEM/ns1:CUSTOMER_ID) }</CUSTOMER_ID>
		                            <CUSTOMER_LEGAL_ID>{ data($PV_CARD_DETAILS_ITEM/ns1:CUSTOMER_LEGAL_ID) }</CUSTOMER_LEGAL_ID>
		                            <CUSTOMER_NAME>{ data($PV_CARD_DETAILS_ITEM/ns1:CUSTOMER_NAME) }</CUSTOMER_NAME>
		                            <NAME_ON_CARD>{ data($PV_CARD_DETAILS_ITEM/ns1:NAME_ON_CARD) }</NAME_ON_CARD>
		                            <EXPIRATION_DATE>{ data($PV_CARD_DETAILS_ITEM/ns1:EXPIRATION_DATE) }</EXPIRATION_DATE>
		                            <CREATION_DATE>{ data($PV_CARD_DETAILS_ITEM/ns1:CREATION_DATE) }</CREATION_DATE>
		                            <BANK_STATUS>{ data($PV_CARD_DETAILS_ITEM/ns1:BANK_STATUS) }</BANK_STATUS>
		                            <EMBOSS_STATUS>{ data($PV_CARD_DETAILS_ITEM/ns1:EMBOSS_STATUS) }</EMBOSS_STATUS>
		                            <PIN_VERIFICATION_VALUE>{ data($PV_CARD_DETAILS_ITEM/ns1:PIN_VERIFICATION_VALUE) }</PIN_VERIFICATION_VALUE>
		                            <SERVICE_CODE>{ data($PV_CARD_DETAILS_ITEM/ns1:SERVICE_CODE) }</SERVICE_CODE>
		                            <ACCOUNT_DETAILS>
		                                {
		                                    for $ACCOUNT_DETAILS_ITEM in $PV_CARD_DETAILS_ITEM/ns1:ACCOUNT_DETAILS/ns1:ACCOUNT_DETAILS_ITEM
		                                    return
		                                    	(
		                                    		if(fn:string($ACCOUNT_DETAILS_ITEM/ns1:ACCOUNT_NUMBER/text()) != '') then(
				                                        <ACCOUNT_ITEM>
				                                            <ORDER_ACCOUNT>{ data($ACCOUNT_DETAILS_ITEM/ns1:ORDER_ACCOUNT) }</ORDER_ACCOUNT>
				                                            <ACCOUNT_NUMBER>{ data($ACCOUNT_DETAILS_ITEM/ns1:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
				                                        </ACCOUNT_ITEM>
			                                       	)else()
		                                        )
		                                }
		                            </ACCOUNT_DETAILS>
		                        </CARD_ITEM>
	                    	)else()
                    	)
                }		
            </CARD_DETAILS>
        </ns0:consultaDetalleTarjetasResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaDetalleTarjetasGTOut($outputParameters)
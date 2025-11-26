(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboce" element="ns0:generaDetalleEmboce" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTarjetasResponse" element="ns0:consultaDetalleTarjetasResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/informacionTarjetaDebito/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";

declare function xf:informacionTarjetaDebito($generaDetalleEmboce as element(ns0:generaDetalleEmboce),
    $consultaDetalleTarjetasResponse as element(ns0:consultaDetalleTarjetasResponse))
    as element(*) {
        <CARD_INFORMATION>
	        <CARD_DETAILS>
	        	{
	        		for $CARD_ITEM in $consultaDetalleTarjetasResponse/CARD_DETAILS/CARD_ITEM[fn:upper-case(BANK_STATUS) = ('MIGRATED', 'ASSOCIATED', 'ISSUED')]
	        			let $INSTRUCTION_CARD := $generaDetalleEmboce/CARD_DETAILS/CARD_ITEM[CARD_NUMBER = $CARD_ITEM/CARD_NUMBER]
	        			return	
			        		<CARD_ITEM>
			        			{
			        				$CARD_ITEM/CARD_NUMBER,
			        				$CARD_ITEM/BIN,
			        				$CARD_ITEM/NAME_ON_CARD,
			        				$CARD_ITEM/EXPIRATION_DATE,
			        				$CARD_ITEM/SERVICE_CODE,
			        				$INSTRUCTION_CARD/INSTRUCTION_DETAILS
			        			}
			        		</CARD_ITEM>
	        	}
	        </CARD_DETAILS>
	    </CARD_INFORMATION>
};

declare variable $generaDetalleEmboce as element(ns0:generaDetalleEmboce) external;
declare variable $consultaDetalleTarjetasResponse as element(ns0:consultaDetalleTarjetasResponse) external;

xf:informacionTarjetaDebito($generaDetalleEmboce,
    $consultaDetalleTarjetasResponse)
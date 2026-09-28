xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Remesas/NotificaEstadoRemesa/xsd/notificaEstadoRemesaContingencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:notificaEstadoRemesaResponse" location="../xsd/notificaEstadoRemesaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesa/xq/notificaEstadoRemesaContingenciaOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaEstadoRemesaContingencia";

declare function xf:notificaEstadoRemesaContingenciaOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:notificaEstadoRemesaResponse) {
        <ns0:notificaEstadoRemesaResponse>
        	<RECORDS_COUNT />
        	<PAID_REMITTANCES>
        	{
        		for $remesas in $outputParameters/ns1:PC_REMESAS/ns1:Row
        		return
        		 <REMITTANCE>
        		 	<REMITANCE_ID>{data($remesas/ns1:Column[@name='FOLIO'])}</REMITANCE_ID>
        		 	<BANK_ID>{data($remesas/ns1:Column[@name='REFERENCIA_PAGO'])}</BANK_ID>
        		 	<STATUS>{data($remesas/ns1:Column[@name='ESTADO_REMESA'])}</STATUS>
        		 	<PAID_DATE>{data($remesas/ns1:Column[@name='FECHA_PAGO'])}</PAID_DATE>
        		 	<PAID_AMOUNT>{data($remesas/ns1:Column[@name='MONTO'])}</PAID_AMOUNT>
        		 	<CURRENCY>{data($remesas/ns1:Column[@name='MONEDAPAGO'])}</CURRENCY>
        		 	<BENEFICIARY_ID_TYPE>{data($remesas/ns1:Column[@name='TIPO_ID_BEN_PAGO'])}</BENEFICIARY_ID_TYPE>
        		 	<BENEFICIARY_ID>{data($remesas/ns1:Column[@name='ID_BEN_PAGO'])}</BENEFICIARY_ID>
        		 	<BENEFICIARY_NAME>{data($remesas/ns1:Column[@name='NOMBREBENEFICIARIO'])}</BENEFICIARY_NAME>
        		 	<CHANNEL_CODE>{data($remesas/ns1:Column[@name='AGENCIA_PAGO'])}</CHANNEL_CODE>
        		 	<CHANNEL_NAME>{data($remesas/ns1:Column[@name='USUARIO_PAGO'])}</CHANNEL_NAME>
        		 	<PAYMENT_ADDRESS />
        		 </REMITTANCE>
        	}
        	</PAID_REMITTANCES>
        </ns0:notificaEstadoRemesaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:notificaEstadoRemesaContingenciaOut($outputParameters)
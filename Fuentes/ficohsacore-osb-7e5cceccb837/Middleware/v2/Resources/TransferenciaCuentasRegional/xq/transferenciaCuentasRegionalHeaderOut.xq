(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/INTFC/transferenciasRegionales/xsd/transferenciasRegionales_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciasRegionales";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentasRegional/xq/tramsferemciaCuentasRegionalHeaderOut/";

declare function xf:tramsferemciaCuentasRegionalHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
                for $PV_IDTRANSACCION in $outputParameters/ns1:PV_IDTRANSACCION
                return
                    <transactionId>{ data($PV_IDTRANSACCION) }</transactionId>
            }
			{
            	let $successIndicator := fn:string($outputParameters/ns1:PV_CODIGOMENSAJE/text())
            	let $message := fn:string($outputParameters/ns1:PV_DESCRIPCIONMENSAJE/text())
            	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }        
            <valueDate>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($outputParameters/ns1:PD_FECHATRANSACCION)) }</valueDate>
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:tramsferemciaCuentasRegionalHeaderOut($outputParameters)

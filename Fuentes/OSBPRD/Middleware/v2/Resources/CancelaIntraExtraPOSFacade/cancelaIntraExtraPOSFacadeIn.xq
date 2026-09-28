(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:gestionesGenericasCRM" location="../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaIntraExtraPOSFacade/cancelaIntraExtraPOSFacadeIn/";

declare function xf:cancelaIntraExtraPOSFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:gestionesGenericasCRM) {
    	let $message := fn:tokenize( data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return(
        	<ns1:gestionesGenericasCRM> 
        		<TYPE>G2</TYPE>
	            <KV_PAIRS>
	                <KV_PAIR>
	                	<KEY>CLIENT_ID</KEY>
	                    <VALUE>{ $message[1] }</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                    <KEY>ACCOUNT_NUMBER</KEY>
	                    <VALUE>{ $message[2] }</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>ACCOUNT_ORG</KEY>
	                	<VALUE>340</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                    <KEY>CARD_NUMBER</KEY>
	                    <VALUE>{ $message[3] }</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>psIdCatalogoDeGestion</KEY>
	                	<VALUE>OPERACIONES DE FINANCIAMIENTO</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>psFlujoDeGestion</KEY>
	                	<VALUE>A-HN OPERACIONES FINANCIAMIENTO</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                    <KEY>Comentarios__c</KEY>
	                    <VALUE>Desde WEB SERVICE</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>Cantidad__c</KEY>
	                	<VALUE>{ $message[4] }</VALUE>
	                </KV_PAIR>
	                 <KV_PAIR>
	                	<KEY>Producto_Reversion__c</KEY>
	                	<VALUE>Intrafinanciamientos</VALUE>
	                </KV_PAIR>
	                 <KV_PAIR>
	                    <KEY>Motivo_Picklist__c</KEY>
	                    <VALUE>Descarga tardía</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>Monto__c</KEY>
	                	<VALUE>{ $message[5] }</VALUE>
	                </KV_PAIR>
	                 <KV_PAIR>
	                	<KEY>Moneda__c</KEY>
	                	<VALUE>Lempira</VALUE>
	                </KV_PAIR>
	                 <KV_PAIR>
	                    <KEY>Fecha__c</KEY>
	                    <VALUE>{ $message[6] }</VALUE>
	                </KV_PAIR>
	               	<KV_PAIR>
	                	<KEY>No_de_Registro__c</KEY>
	                	<VALUE>{ $message[7] }</VALUE>
	                </KV_PAIR>
	                <KV_PAIR>
	                	<KEY>Numero_de_Poliza_Banco__c</KEY>
	                	<VALUE>{ $message[8] }</VALUE>
	                </KV_PAIR>
	            </KV_PAIRS>
        	</ns1:gestionesGenericasCRM>
        )
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:cancelaIntraExtraPOSFacadeIn($procesaMensajeGenericoT24)
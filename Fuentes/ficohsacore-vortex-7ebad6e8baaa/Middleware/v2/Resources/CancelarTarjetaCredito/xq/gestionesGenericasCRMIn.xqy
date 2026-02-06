xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelarTarjetaCredito" element="ns1:cancelarTarjetaCredito" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:gestionesGenericasCRM" location="../../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/gestionesGenericasCRMIn/";

declare function xf:gestionesGenericasCRMIn($cancelarTarjetaCredito as element(ns1:cancelarTarjetaCredito),
    $clientId as xs:string)
    as element(ns0:gestionesGenericasCRM) {
        <ns0:gestionesGenericasCRM>
        	<TYPE>G2</TYPE>
            <KV_PAIRS>
                <KV_PAIR>
                	<KEY>CLIENT_ID</KEY>
                    <VALUE>{ $clientId }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>ACCOUNT_NUMBER</KEY>
                    <VALUE>{ data($cancelarTarjetaCredito/CREDIT_CARD_INFO/ACCOUNT_NUMBER) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                	<KEY>ACCOUNT_ORG</KEY>
                	<VALUE>340</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>CARD_NUMBER</KEY>
                    <VALUE>{ data($cancelarTarjetaCredito/CREDIT_CARD_INFO/CARD_NUMBER) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                	<KEY>psIdCatalogoDeGestion</KEY>
                	<VALUE>CANCELACION DE CUENTA</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                	<KEY>psFlujoDeGestion</KEY>
                	<VALUE>A-HN CANCELACION CUENTA</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Comentarios__c</KEY>
                    <VALUE>{ data($cancelarTarjetaCredito/CANCELLATION_DETAILS/SUBJECT) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                	<KEY>Razon_del_Bloqueo__c</KEY>
                	<VALUE>B20-Consolidación de Deuda</VALUE>
                </KV_PAIR>
                 <KV_PAIR>
                	<KEY>Tipo_de_Bloqueo__c</KEY>
                	<VALUE>B - Cancelacion Involuntaria</VALUE>
                </KV_PAIR>
            </KV_PAIRS>
        </ns0:gestionesGenericasCRM>
};

declare variable $cancelarTarjetaCredito as element(ns1:cancelarTarjetaCredito) external;
declare variable $clientId as xs:string external;

xf:gestionesGenericasCRMIn($cancelarTarjetaCredito,
    $clientId)
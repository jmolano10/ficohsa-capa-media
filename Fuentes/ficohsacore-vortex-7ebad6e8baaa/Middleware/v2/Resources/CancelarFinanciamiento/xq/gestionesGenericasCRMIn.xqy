xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$conDatoCuentaResponse" element="ns2:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelarFinanciamientoRequest" element="ns1:cancelarFinanciamiento" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:gestionesGenericasCRM" location="../../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/gestionesGenericasCRMIn/";

declare function xf:gestionesGenericasCRMIn($cancelarFinanciamientoRequest as element(ns1:cancelarFinanciamiento),
    $transferenciaCuentas as xs:string,
    $clientId as xs:string)
    as element(ns0:gestionesGenericasCRM) {
        <ns0:gestionesGenericasCRM>
            <TYPE>G2</TYPE>
            <KV_PAIRS>
                <KV_PAIR>
                    <KEY>CLIENT_ID</KEY>
                    <VALUE>{ xs:decimal ($clientId) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>ACCOUNT_NUMBER</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/CREDIT_CARD_INFO/ACCOUNT_NUMBER) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>ACCOUNT_ORG</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/FINANCING_DETAILS/ORG) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>CARD_NUMBER</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/CREDIT_CARD_INFO/CARD_NUMBER) }</VALUE>
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
                    <VALUE>{ fn:concat("Área Gestiona Créditos, Pago anticipado, CUT#", " ",data($cancelarFinanciamientoRequest/FINANCING_DETAILS/ID), " ","FT#", " ",$transferenciaCuentas) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Cantidad__c</KEY>
                    <VALUE/>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Producto_Reversion__c</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/FINANCING_DETAILS/TYPE) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Motivo_Picklist__c</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/CANCELLATION_DETAILS/SUBJECT) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Monto__c</KEY>
                    <VALUE>{ data($cancelarFinanciamientoRequest/CANCELLATION_DETAILS/AMOUNT) }</VALUE>
                </KV_PAIR>
                <KV_PAIR>
                    <KEY>Moneda__c</KEY>
                    {
                    	if(data($cancelarFinanciamientoRequest/FINANCING_DETAILS/CURRENCY) = '340')then(
                    	
                    		<VALUE>Lempira</VALUE>
                    		
                    	)else if(data($cancelarFinanciamientoRequest/FINANCING_DETAILS/CURRENCY) = '840')then(
                    		
                    		<VALUE>USD</VALUE>
                    	)else (
                    	
                    		<VALUE/>
                    	)          	
                    }
                </KV_PAIR>
            </KV_PAIRS>
        </ns0:gestionesGenericasCRM>
};

declare variable $cancelarFinanciamientoRequest as element(ns1:cancelarFinanciamiento) external;
declare variable $transferenciaCuentas as xs:string external;
declare variable $clientId as xs:string external;

xf:gestionesGenericasCRMIn($cancelarFinanciamientoRequest,
    $transferenciaCuentas,
    $clientId)
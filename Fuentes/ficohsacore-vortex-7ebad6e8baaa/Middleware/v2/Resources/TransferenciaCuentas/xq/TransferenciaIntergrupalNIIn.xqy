xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestBody" element="ns1:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns3:opTransferenciaRegionalSolicitud" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/CTS/TransferenciaIntergrupal/xq/TransferenciaIntergrupalIn/";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function xf:TransferenciaIntergrupalIn($requestBody as element(ns1:transferenciaCuentasRequest),
    $mode as xs:string,
    $operationType as xs:string,
    $reference as xs:string)
    as element(ns3:opTransferenciaRegionalSolicitud) {
        <ns3:opTransferenciaRegionalSolicitud>
            <ns2:paisOrigen>{ substring($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'BANK']/VALUE/text(),1, 2) }</ns2:paisOrigen>
            <ns2:paisDestino>{ substring($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'BANK']/VALUE/text(),1, 2) }</ns2:paisDestino>
            <ns2:modo>{ $mode }</ns2:modo>
            <ns2:productoDebito>{ $requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'PRODUCT_TYPE']/VALUE/text() }</ns2:productoDebito>
            <ns2:ctaDebito>{ data($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT']/VALUE) }</ns2:ctaDebito>
            <ns2:monedaDebito>{ data($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT_CURRENCY']/VALUE) }</ns2:monedaDebito>
            <ns2:montoDebito>{ data($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_AMOUNT']/VALUE) }</ns2:montoDebito>
            <ns2:nombreRemitente>{ data($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE) }</ns2:nombreRemitente>
            <ns2:productoCredito>{ data($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'PRODUCT_TYPE']/VALUE) }</ns2:productoCredito>
            <ns2:ctaCredito>{ data($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_ACCOUNT']/VALUE) }</ns2:ctaCredito>
            <ns2:monedaCredito>{ data($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_CURRENCY']/VALUE) }</ns2:monedaCredito>
            <ns2:montoCredito>{ data($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_AMOUNT']/VALUE) }</ns2:montoCredito>
            <ns2:nombreBeneficiario>{ data($requestBody/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE) }</ns2:nombreBeneficiario>
            <ns2:monto>{ xs:double($requestBody/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'USD_AMOUNT']/VALUE/text()) }</ns2:monto>
            <ns2:moneda>USD</ns2:moneda>
            {
                for $DESCRIPTION in $requestBody/DESCRIPTION
                return
                    <ns2:concepto>{ data($DESCRIPTION) }</ns2:concepto>
            }
            <ns2:referencia>{ $reference }</ns2:referencia>
            <ns2:tipoOperacion>{ $operationType }</ns2:tipoOperacion>
        </ns3:opTransferenciaRegionalSolicitud>
};

declare variable $requestBody as element(ns1:transferenciaCuentasRequest) external;
declare variable $mode as xs:string external;
declare variable $operationType as xs:string external;
declare variable $reference as xs:string external;

xf:TransferenciaIntergrupalIn($requestBody,
    $mode,
    $operationType,
    $reference)
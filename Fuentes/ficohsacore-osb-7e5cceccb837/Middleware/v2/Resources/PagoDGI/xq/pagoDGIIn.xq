(:: pragma bea:global-element-parameter parameter="$pagoDGIRequest" element="ns0:pagoDGIRequest" location="../xsd/pagoDGITypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opPagoDGISolicitud" location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoDGITypes";
declare namespace ns2 = "http://service.srvaplcobisimpuestos.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDGI/xq/pagoDGIIn/";

(: Función encargada de realizar el calculo del indicador de pago:)
declare function obtenerIndicadorPago($valTotal as xs:decimal, $valPago as xs:decimal)  as xs:string { 
	let $data :=  
		if(($valTotal - $valPago) = 0) then
			'1'
		else
			'2'
	return $data
 };

declare function xf:pagoDGIIn($pagoDGIRequest as element(ns0:pagoDGIRequest),
    $cajaDGI as xs:string,
    $formaPagoDGI as xs:string,
    $codigoBancoDGI as xs:string,
    $tipoImpuestoDGI as xs:string)
    as element(ns2:opPagoDGISolicitud) {
        <ns2:opPagoDGISolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:datosPagN900>
                <ns1:bit>{ data($pagoDGIRequest/BILL_NUMBER) }</ns1:bit>
                <ns1:valMontoPago>{ data($pagoDGIRequest/PAYMENT_AMOUNT) }</ns1:valMontoPago>
                <ns1:fechaPago>{  fn:adjust-dateTime-to-timezone(current-dateTime(),()) }</ns1:fechaPago>
                <ns1:horaPago>{ fn-bea:dateTime-to-string-with-format("HH:mm:ss", fn:adjust-dateTime-to-timezone(current-dateTime(),()) )  }</ns1:horaPago>
                <ns1:indicadorPago>{ obtenerIndicadorPago(data($pagoDGIRequest/TOTAL_AMOUNT), data($pagoDGIRequest/PAYMENT_AMOUNT) ) }</ns1:indicadorPago>
                <ns1:formaPago>{ $formaPagoDGI }</ns1:formaPago>
                <ns1:codigoBanco>{ $codigoBancoDGI }</ns1:codigoBanco>
                <ns1:caja>{ $cajaDGI }</ns1:caja>
                <ns1:valImpuesto>{ data($pagoDGIRequest/TAX_VALUE) }</ns1:valImpuesto>
                <ns1:valMontoMantenimiento>{ data($pagoDGIRequest/EXCH_RATE_FEE) }</ns1:valMontoMantenimiento>
                <ns1:valMora>{ data($pagoDGIRequest/LATE_FEE) }</ns1:valMora>
                <ns1:valMulta>{ data($pagoDGIRequest/PENALTY_FEE) }</ns1:valMulta>
                <ns1:tipoImpuesto>{ $tipoImpuestoDGI }</ns1:tipoImpuesto>
                <ns1:tipoImpuestoTributario>{ data($pagoDGIRequest/TAX_DESCRIPTION) }</ns1:tipoImpuestoTributario>
                <ns1:codigoCuenta>{ data($pagoDGIRequest/ACCOUNT_CODE) }</ns1:codigoCuenta>
                <ns1:valRUC>{ data($pagoDGIRequest/RUC) }</ns1:valRUC>
                <ns1:fechaVencimiento>{ xs:date($pagoDGIRequest/DUE_DATE) cast as xs:dateTime }</ns1:fechaVencimiento>
                <ns1:valMontoBit>{data($pagoDGIRequest/TOTAL_AMOUNT) }</ns1:valMontoBit>
                <ns1:cuenta>{ data($pagoDGIRequest/ACCOUNT_NUMBER) }</ns1:cuenta>
            </ns1:datosPagN900>
        </ns2:opPagoDGISolicitud>
};

declare variable $pagoDGIRequest as element(ns0:pagoDGIRequest) external;
declare variable $cajaDGI as xs:string external;
declare variable $formaPagoDGI as xs:string external;
declare variable $codigoBancoDGI as xs:string external;
declare variable $tipoImpuestoDGI as xs:string external;

xf:pagoDGIIn($pagoDGIRequest,
    $cajaDGI,
    $formaPagoDGI,
    $codigoBancoDGI,
    $tipoImpuestoDGI)

xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLote" element="ns2:consultaDetalleLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultarDetalleLote" location="../../../BusinessServices/MTR/consultorDetalleLote/wsdl/consultorDetalleLoteEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLotePAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.consultadetallelotepmsws.mtrpmsv.cidenet.com.co/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";

declare function ispagin($item as item())as xs:string{
	let $ispagin:= fn-bea:trim(upper-case(fn:string($item/text())))
	return
		if($ispagin = 'YES')then(
			'S'
		)
		else if ($ispagin = 'NO')then(
			'N'
		)
		else('')
};

declare function xf:consultaDetalleLotePAIn($requestHeader as element(ns3:RequestHeader),
    $consultaDetalleLote as element(ns2:consultaDetalleLote))
    as element(ns1:consultarDetalleLote) {
        <ns1:consultarDetalleLote>
            <idCliente>{ data($consultaDetalleLote/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($requestHeader/Authentication/UserName) }</idUsuario>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            <tipoConsulta>{ data($consultaDetalleLote/QUERY_TYPE) }</tipoConsulta>
            <identificadorLote>{ data($consultaDetalleLote/QUERY_VALUE) }</identificadorLote>
            {
                for $TRANSACTION_FILTERS in $consultaDetalleLote/TRANSACTION_FILTERS
                return
                    <filtrosTransacciones>
                        {
                            for $FILTER in $TRANSACTION_FILTERS/FILTER
                            return
                                <filtroTransaccion>
                                    {
                                        for $FIELD in $FILTER/FIELD
                                        return
                                            <campo>{ data($FIELD) }</campo>
                                    }
                                    {
                                        for $VALUE in $FILTER/VALUE
                                        return
                                            <valor>{ data($VALUE) }</valor>
                                    }
                                </filtroTransaccion>
                        }
                    </filtrosTransacciones>
            }
            {
                let $PAGING_INFO := $consultaDetalleLote/PAGING_INFO
                return
                    <paginacion>
                        <cantidadRegistros>{ data($PAGING_INFO/RECORD_COUNT) }</cantidadRegistros>
                        {
                        	for $PAGING in $consultaDetalleLote/PAGING_INFO/PAGING
                        	return
                        		<esPaginada>{ ispagin($PAGING) }</esPaginada>
                        }
                        <registroInicial>{ data($PAGING_INFO/INITIAL_RECORD) }</registroInicial>
                    </paginacion>
            }
        </ns1:consultarDetalleLote>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $consultaDetalleLote as element(ns2:consultaDetalleLote) external;

xf:consultaDetalleLotePAIn($requestHeader,
    $consultaDetalleLote)
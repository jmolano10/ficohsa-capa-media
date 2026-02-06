xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagosMasivos" element="ns1:pagosMasivos" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cargarLotes" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:pagosMasivosInternoPAIn($requestHeader as element(ns2:RequestHeader),
    $pagosMasivos as element(ns1:pagosMasivos))
    as element(ns0:cargarLotes) {
        <ns0:cargarLotes>
            <solicitudHostToHost>
                <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
                <idCliente>{ data($pagosMasivos/CUSTOMER_ID) }</idCliente>
                <idGlobal>{ data($pagosMasivos/GLOBAL_ID) }</idGlobal>
                <idUsuario>{ data($pagosMasivos/USERNAME) }</idUsuario>
                <usuarioCanal>{ data($requestHeader/Authentication/UserName) }</usuarioCanal>
                {
                    let $BATCHES := $pagosMasivos/BATCHES
                    return
                        <lotes>
                            {
                                for $BATCH in $BATCHES/BATCH
                                return
                                    <lote>
                                     
                                        {
                                            let $DATA_STRUCTURE := $BATCH/DATA_STRUCTURE
                                            return
                                                <estructuraDatos>
                                                    {
                                                        let $FIELDS := $DATA_STRUCTURE/FIELDS
                                                        return
                                                            <campos>
                                                                {
                                                                    for $FIELD in $FIELDS/FIELD
                                                                    return
                                                                        <campo>{ data($FIELD) }</campo>
                                                                }
                                                            </campos>
                                                    }
                                                    <separador>{ data($DATA_STRUCTURE/DELIMITER) }</separador>
                                                    {
                                                        let $VALIDATIONS := $DATA_STRUCTURE/VALIDATIONS
                                                        return
                                                            <validaciones>
                                                                <cantidadTransacciones>{ data($VALIDATIONS/NUMBER_OF_TRANSACTIONS) }</cantidadTransacciones>
                                                                <estadoCuentaDebito>
                                                                { 
                                                                	let $DEBIT_ACCT_STATUS := upper-case(data($VALIDATIONS/DEBIT_ACCT_STATUS)) 
                                                                	return
                                                                		if ($DEBIT_ACCT_STATUS = 'YES') then (
                                                                			'S'
                                                                		) else (
                                                                			'N'
                                                                		)
                                                                }
                                                                </estadoCuentaDebito>
                                                                <montoTotal>{ data($VALIDATIONS/TOTAL_AMOUNT) }</montoTotal>
                                                                <saldoCuentaDebito>
                                                                { 
                                                                	let $DEBIT_ACCT_BALANCE := upper-case(data($VALIDATIONS/DEBIT_ACCT_BALANCE)) 
                                                                	return
                                                                		if ($DEBIT_ACCT_BALANCE = 'YES') then (
                                                                			'S'
                                                                		) else (
                                                                			'N'
                                                                		)
                                                                }
                                                                </saldoCuentaDebito>
                                                            </validaciones>
                                                    }
                                                </estructuraDatos>
                                        }
                                        {
                                            for $APPLICATION_DATE in $BATCH/APPLICATION_DATE
                                            return
                                                <fechaEsperadaAplicacion>{ data($APPLICATION_DATE) }</fechaEsperadaAplicacion>
                                        }
                                        <idLoteCliente>{ data($BATCH/CUSTOMER_BATCH_ID) }</idLoteCliente>
                                        <idTipoOperacion>{ data($BATCH/TYPE) }</idTipoOperacion>
                                       
                                        {
                                            let $TRANSACTIONS := $BATCH/TRANSACTIONS
                                            return
                                                <transacciones>
                                                    {
                                                        for $TRANSACTION in $TRANSACTIONS/TRANSACTION
                                                        return
                                                            <transaccion>{ data($TRANSACTION) }</transaccion>
                                                    }
                                                </transacciones>
                                        }
                                    </lote>
                            }
                        </lotes>
                }
            </solicitudHostToHost>
        </ns0:cargarLotes>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagosMasivos as element(ns1:pagosMasivos) external;

xf:pagosMasivosInternoPAIn($requestHeader,
    $pagosMasivos)
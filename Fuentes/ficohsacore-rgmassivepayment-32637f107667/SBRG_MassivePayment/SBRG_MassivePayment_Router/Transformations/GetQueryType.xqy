xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $operation as xs:string external;
declare variable $body as element() external;

declare function local:func(
    $operation as xs:string, 
    $body as element()
    ) as xs:string {
    if ($operation = 'pagosMasivos') then
        'OPERATION_TYPE'
    else if ($operation = 'consultaLotesCliente') then
        ''
    else if ($operation = 'consultaDetalleLote') then
        fn:data($body//QUERY_TYPE)
    else if ($operation = 'consultaTransaccionLote') then
        'TXN_REFERENCE'
    else if ($operation = 'cargarArchivoLote') then
        'OPERATION_TYPE'
    else if ($operation = 'autorizarLote') then
        'BANK_BATCH_ID'
    else if ($operation = 'cancelarLote') then
        'BANK_BATCH_ID'
    else if ($operation = 'editarEstadoRegistroLote') then
        'BANK_BATCH_ID'
    else if ($operation = 'consultaEstadoLote') then
        'BANK_BATCH_ID'
    else if ($operation = 'cargarProveedores') then
        ''
    else if ($operation = 'consultarProveedores') then
        ''
    else if ($operation = 'autorizarProveedores') then
        ''
    else if ($operation = 'eliminarProveedores') then
        ''
    else ()
};

local:func($operation, $body)
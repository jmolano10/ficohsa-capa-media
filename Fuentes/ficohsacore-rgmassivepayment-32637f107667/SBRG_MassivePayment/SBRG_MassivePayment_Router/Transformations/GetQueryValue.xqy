xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $operation as xs:string external;
declare variable $body as element() external;

declare function local:func(
    $operation as xs:string,
    $body as element()
    ) as xs:string {
    if ($operation = 'pagosMasivos') then
        fn:data($body//BATCHES/BATCH[1]/TYPE)
    else if ($operation = 'consultaLotesCliente') then
        ''
    else if ($operation = 'consultaDetalleLote') then
        fn:data($body//QUERY_VALUE)
    else if ($operation = 'consultaTransaccionLote') then
        fn:data($body//TXN_REFERENCE)
    else if ($operation = 'cargarArchivoLote') then
        fn:data($body//TYPE)
    else if ($operation = 'autorizarLote') then
        fn:data($body//BATCHES/BATCH/BANK_BATCH_ID)
    else if ($operation = 'cancelarLote') then
        fn:data($body//BANK_BATCH_ID)
    else if ($operation = 'editarEstadoRegistroLote') then
        fn:data($body//BANK_BATCH_ID)
    else if ($operation = 'consultaEstadoLote') then
        fn:data($body//BANK_BATCH_ID)
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
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$resultadoCalificacionBlaze" element="ns0:resultadoCalificacionBlaze" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:precualifyResult" location="../../../BusinessServices/SALESFORCE/recepEvalCreditosPA/wsdl/WS_PAN_Blaze_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_Blaze_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ResultadoCalificacionBlaze/xq/precualifyResultPAIn/";

declare function xf:precualifyResultPAIn($resultadoCalificacionBlaze as element(ns0:resultadoCalificacionBlaze))
    as element(ns1:precualifyResult) {
        <ns1:precualifyResult>
            <ns1:parametros>
                {
                    for $REFERENCE_CREDITOR in $resultadoCalificacionBlaze/REFERENCE_CREDITOR
                    return
                        <ns1:AcreedorReferencia>{ data($REFERENCE_CREDITOR) }</ns1:AcreedorReferencia>
                }
                {
                    for $BUREAU_SCORE in $resultadoCalificacionBlaze/BUREAU_SCORE
                    return
                        <ns1:CalificacionRiesgo>{ data($BUREAU_SCORE) }</ns1:CalificacionRiesgo>
                }
                {
                    for $PIL_RESULTCODE_PROD1 in $resultadoCalificacionBlaze/PIL_RESULTCODE_PROD1
                    return
                        <ns1:codigoResultadoPil_Prod1>{ data($PIL_RESULTCODE_PROD1) }</ns1:codigoResultadoPil_Prod1>
                }
                {
                    for $PIL_RESULTCODE_PROD2 in $resultadoCalificacionBlaze/PIL_RESULTCODE_PROD2
                    return
                        <ns1:codigoResultadoPil_Prod2>{ data($PIL_RESULTCODE_PROD2) }</ns1:codigoResultadoPil_Prod2>
                }
                {
                    for $PIL_RESULTCODE_PROD3 in $resultadoCalificacionBlaze/PIL_RESULTCODE_PROD3
                    return
                        <ns1:codigoResultadoPil_Prod3>{ data($PIL_RESULTCODE_PROD3) }</ns1:codigoResultadoPil_Prod3>
                }
                {
                    for $RESULTCODE_PROD1 in $resultadoCalificacionBlaze/RESULTCODE_PROD1
                    return
                        <ns1:codigoResultadoTC_Prod1>{ data($RESULTCODE_PROD1) }</ns1:codigoResultadoTC_Prod1>
                }
                {
                    for $RESULTCODE_PROD2 in $resultadoCalificacionBlaze/RESULTCODE_PROD2
                    return
                        <ns1:codigoResultadoTC_Prod2>{ data($RESULTCODE_PROD2) }</ns1:codigoResultadoTC_Prod2>
                }
                {
                    for $RESULTCODE_PROD3 in $resultadoCalificacionBlaze/RESULTCODE_PROD3
                    return
                        <ns1:codigoResultadoTC_Prod3>{ data($RESULTCODE_PROD3) }</ns1:codigoResultadoTC_Prod3>
                }
                {
                    for $PIL_MAXFEE_PROD1 in $resultadoCalificacionBlaze/PIL_MAXFEE_PROD1
                    return
                        <ns1:CuotaMaxPil_Prod1>{ data($PIL_MAXFEE_PROD1) }</ns1:CuotaMaxPil_Prod1>
                }
                {
                    for $PIL_MAXFEE_PROD2 in $resultadoCalificacionBlaze/PIL_MAXFEE_PROD2
                    return
                        <ns1:CuotaMaxPil_Prod2>{ data($PIL_MAXFEE_PROD2) }</ns1:CuotaMaxPil_Prod2>
                }
                {
                    for $PIL_MAXFEE_PROD3 in $resultadoCalificacionBlaze/PIL_MAXFEE_PROD3
                    return
                        <ns1:CuotaMaxPil_Prod3>{ data($PIL_MAXFEE_PROD3) }</ns1:CuotaMaxPil_Prod3>
                }
                {
                    for $CREDIT_EXPERIENCE in $resultadoCalificacionBlaze/CREDIT_EXPERIENCE
                    return
                        <ns1:ExpCred>{ data($CREDIT_EXPERIENCE) }</ns1:ExpCred>
                }
                {
                    for $ID_VALUE in $resultadoCalificacionBlaze/ID_VALUE
                    return
                        <ns1:identidad>{ data($ID_VALUE) }</ns1:identidad>
                }
                {
                    for $REFERENCE_AMOUNT in $resultadoCalificacionBlaze/REFERENCE_AMOUNT
                    return
                        <ns1:LimiteMontoReferencia>{ data($REFERENCE_AMOUNT) }</ns1:LimiteMontoReferencia>
                }
                {
                    for $SUGGESTED_LIMIT_PROD1 in $resultadoCalificacionBlaze/SUGGESTED_LIMIT_PROD1
                    return
                        <ns1:limiteSugeridoProd1>{ data($SUGGESTED_LIMIT_PROD1) }</ns1:limiteSugeridoProd1>
                }
                {
                    for $SUGGESTED_LIMIT_PROD2 in $resultadoCalificacionBlaze/SUGGESTED_LIMIT_PROD2
                    return
                        <ns1:limiteSugeridoProd2>{ data($SUGGESTED_LIMIT_PROD2) }</ns1:limiteSugeridoProd2>
                }
                {
                    for $SUGGESTED_LIMIT_PROD3 in $resultadoCalificacionBlaze/SUGGESTED_LIMIT_PROD3
                    return
                        <ns1:limiteSugeridoProd3>{ data($SUGGESTED_LIMIT_PROD3) }</ns1:limiteSugeridoProd3>
                }
                {
                    for $NDE in $resultadoCalificacionBlaze/NDE
                    return
                        <ns1:NDE>{ data($NDE) }</ns1:NDE>
                }
                {
                    for $REQUEST_NUMBER in $resultadoCalificacionBlaze/REQUEST_NUMBER
                    return
                        <ns1:noSolicitud>{ data($REQUEST_NUMBER) }</ns1:noSolicitud>
                }
                <ns1:NoTicket>{ data($resultadoCalificacionBlaze/TICKET_NUMBER) }</ns1:NoTicket>
                {
                    for $PIL_OFFER12_PROD1 in $resultadoCalificacionBlaze/PIL_OFFER12_PROD1
                    return
                        <ns1:Oferta12_Pil_Prod1>{ data($PIL_OFFER12_PROD1) }</ns1:Oferta12_Pil_Prod1>
                }
                {
                    for $PIL_OFFER12_PROD2 in $resultadoCalificacionBlaze/PIL_OFFER12_PROD2
                    return
                        <ns1:Oferta12_Pil_Prod2>{ data($PIL_OFFER12_PROD2) }</ns1:Oferta12_Pil_Prod2>
                }
                {
                    for $PIL_OFFER12_PROD3 in $resultadoCalificacionBlaze/PIL_OFFER12_PROD3
                    return
                        <ns1:Oferta12_Pil_Prod3>{ data($PIL_OFFER12_PROD3) }</ns1:Oferta12_Pil_Prod3>
                }
                {
                    for $PIL_OFFER24_PROD1 in $resultadoCalificacionBlaze/PIL_OFFER24_PROD1
                    return
                        <ns1:Oferta24_Pil_Prod1>{ data($PIL_OFFER24_PROD1) }</ns1:Oferta24_Pil_Prod1>
                }
                {
                    for $PIL_OFFER24_PROD2 in $resultadoCalificacionBlaze/PIL_OFFER24_PROD2
                    return
                        <ns1:Oferta24_Pil_Prod2>{ data($PIL_OFFER24_PROD2) }</ns1:Oferta24_Pil_Prod2>
                }
                {
                    for $PIL_OFFER24_PROD3 in $resultadoCalificacionBlaze/PIL_OFFER24_PROD3
                    return
                        <ns1:Oferta24_Pil_Prod3>{ data($PIL_OFFER24_PROD3) }</ns1:Oferta24_Pil_Prod3>
                }
                {
                    for $PIL_OFFER36_PROD1 in $resultadoCalificacionBlaze/PIL_OFFER36_PROD1
                    return
                        <ns1:Oferta36_Pil_Prod1>{ data($PIL_OFFER36_PROD1) }</ns1:Oferta36_Pil_Prod1>
                }
                {
                    for $PIL_OFFER36_PROD2 in $resultadoCalificacionBlaze/PIL_OFFER36_PROD2
                    return
                        <ns1:Oferta36_Pil_Prod2>{ data($PIL_OFFER36_PROD2) }</ns1:Oferta36_Pil_Prod2>
                }
                {
                    for $PIL_OFFER36_PROD3 in $resultadoCalificacionBlaze/PIL_OFFER36_PROD3
                    return
                        <ns1:Oferta36_Pil_Prod3>{ data($PIL_OFFER36_PROD3) }</ns1:Oferta36_Pil_Prod3>
                }
                {
                    for $PIL_OFFER48_PROD1 in $resultadoCalificacionBlaze/PIL_OFFER48_PROD1
                    return
                        <ns1:Oferta48_Pil_Prod1>{ data($PIL_OFFER48_PROD1) }</ns1:Oferta48_Pil_Prod1>
                }
                {
                    for $PIL_OFFER48_PROD2 in $resultadoCalificacionBlaze/PIL_OFFER48_PROD2
                    return
                        <ns1:Oferta48_Pil_Prod2>{ data($PIL_OFFER48_PROD2) }</ns1:Oferta48_Pil_Prod2>
                }
                {
                    for $PIL_OFFER48_PROD3 in $resultadoCalificacionBlaze/PIL_OFFER48_PROD3
                    return
                        <ns1:Oferta48_Pil_Prod3>{ data($PIL_OFFER48_PROD3) }</ns1:Oferta48_Pil_Prod3>
                }
                {
                    for $PIL_OFFER60_PROD1 in $resultadoCalificacionBlaze/PIL_OFFER60_PROD1
                    return
                        <ns1:Oferta60_Pil_Prod1>{ data($PIL_OFFER60_PROD1) }</ns1:Oferta60_Pil_Prod1>
                }
                {
                    for $PIL_OFFER60_PROD2 in $resultadoCalificacionBlaze/PIL_OFFER60_PROD2
                    return
                        <ns1:Oferta60_Pil_Prod2>{ data($PIL_OFFER60_PROD2) }</ns1:Oferta60_Pil_Prod2>
                }
                {
                    for $PIL_OFFER60_PROD3 in $resultadoCalificacionBlaze/PIL_OFFER60_PROD3
                    return
                        <ns1:Oferta60_Pil_Prod3>{ data($PIL_OFFER60_PROD3) }</ns1:Oferta60_Pil_Prod3>
                }
                {
                    for $RCI in $resultadoCalificacionBlaze/RCI
                    return
                        <ns1:RCI>{ data($RCI) }</ns1:RCI>
                }
                {
                    for $PIL_SOURCECODE_PROD1 in $resultadoCalificacionBlaze/PIL_SOURCECODE_PROD1
                    return
                        <ns1:SourceCode_Pil_Prod1>{ data($PIL_SOURCECODE_PROD1) }</ns1:SourceCode_Pil_Prod1>
                }
                {
                    for $PIL_SOURCECODE_PROD2 in $resultadoCalificacionBlaze/PIL_SOURCECODE_PROD2
                    return
                        <ns1:SourceCode_Pil_Prod2>{ data($PIL_SOURCECODE_PROD2) }</ns1:SourceCode_Pil_Prod2>
                }
                {
                    for $PIL_SOURCECODE_PROD3 in $resultadoCalificacionBlaze/PIL_SOURCECODE_PROD3
                    return
                        <ns1:SourceCode_Pil_Prod3>{ data($PIL_SOURCECODE_PROD3) }</ns1:SourceCode_Pil_Prod3>
                }
                {
                    for $SOURCECODE_PROD1 in $resultadoCalificacionBlaze/SOURCECODE_PROD1
                    return
                        <ns1:SourceCodeTC_prod1>{ data($SOURCECODE_PROD1) }</ns1:SourceCodeTC_prod1>
                }
                {
                    for $SOURCECODE_PROD2 in $resultadoCalificacionBlaze/SOURCECODE_PROD2
                    return
                        <ns1:SourceCodeTC_prod2>{ data($SOURCECODE_PROD2) }</ns1:SourceCodeTC_prod2>
                }
                {
                    for $SOURCECODE_PROD3 in $resultadoCalificacionBlaze/SOURCECODE_PROD3
                    return
                        <ns1:SourceCodeTC_prod3>{ data($SOURCECODE_PROD3) }</ns1:SourceCodeTC_prod3>
                }
                {
                    for $PIL_RATE_PROD1 in $resultadoCalificacionBlaze/PIL_RATE_PROD1
                    return
                        <ns1:tasaPil_Prod1>{ data($PIL_RATE_PROD1) }</ns1:tasaPil_Prod1>
                }
                {
                    for $PIL_RATE_PROD2 in $resultadoCalificacionBlaze/PIL_RATE_PROD2
                    return
                        <ns1:tasaPil_Prod2>{ data($PIL_RATE_PROD2) }</ns1:tasaPil_Prod2>
                }
                {
                    for $PIL_RATE_PROD3 in $resultadoCalificacionBlaze/PIL_RATE_PROD3
                    return
                        <ns1:tasaPil_Prod3>{ data($PIL_RATE_PROD3) }</ns1:tasaPil_Prod3>
                }
                {
                    for $CUSTOMER_PROFILE in $resultadoCalificacionBlaze/CUSTOMER_PROFILE
                    return
                        <ns1:tipoClienteRiesgo>{ data($CUSTOMER_PROFILE) }</ns1:tipoClienteRiesgo>
                }
                {
                    for $REFERENCE_TYPE in $resultadoCalificacionBlaze/REFERENCE_TYPE
                    return
                        <ns1:tipoReferenciaAsignacion>{ data($REFERENCE_TYPE) }</ns1:tipoReferenciaAsignacion>
                }
            </ns1:parametros>
        </ns1:precualifyResult>
};

declare variable $resultadoCalificacionBlaze as element(ns0:resultadoCalificacionBlaze) external;

xf:precualifyResultPAIn($resultadoCalificacionBlaze)
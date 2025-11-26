(:: pragma bea:global-element-parameter parameter="$consultaDatosACHEnviadoResponse" element="ns0:ConsultaDatosACHEnviadoResponse" location="../../../BusinessServices/ACH/Enviado/SvcACHEnviado/xsd/XMLSchema_-1255526967.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ACH/Enviado/ActualizaRegistroACHEnviado/xsd/actualizaRegistroACHEnviado_sp.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaRegistroACHEnviado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/actualizaRegistroACHEnviadoIn/";

declare function xf:actualizaRegistroACHEnviadoIn($consultaDatosACHEnviadoResponse as element(ns0:ConsultaDatosACHEnviadoResponse),
    $achSecuencia as xs:string,
    $codigoProceso as xs:string,
    $refControlT24 as xs:string,
    $pxpIdRef as xs:string,
    $estadoProceso as xs:string,
    $codigoErrorProceso as xs:string,
    $mensajeErrorProceso as xs:string,
    $pxpResult as xs:string,
    $pxpErrorCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_ACHSECUENCIA>{ $achSecuencia }</ns1:PN_ACHSECUENCIA>
            <ns1:PN_CODIGOPROCESO>{ $codigoProceso }</ns1:PN_CODIGOPROCESO>
            {
                for $ACHROUTINGNUM in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/ACHROUTINGNUM
                return
                    <ns1:PV_RUTATRANSITO>
                        {
                            if (empty(data($ACHROUTINGNUM))) then
                                ('')
                            else 
                                data($ACHROUTINGNUM)
                        }
					</ns1:PV_RUTATRANSITO>
            }
            <ns1:PN_IDCLIENTE>
                {
                    let $customerId  := (data($consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/CUSTOMERID))  
                    return
                        if (empty($customerId)) then
                            (xs:decimal(0))
                        else 
                            $customerId
                }
			</ns1:PN_IDCLIENTE>
            {
                for $ISLBTR in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/ISLBTR
                return
                    <ns1:PV_ESLBTR>
                        {
                            if (empty(data($ISLBTR))) then
                                ('')
                            else 
                                data($ISLBTR)
                        }
					</ns1:PV_ESLBTR>
            }
            <ns1:PV_REFCONTROLT24>{ $refControlT24 }</ns1:PV_REFCONTROLT24>
            <ns1:PV_PXPIDREF>{ $pxpIdRef }</ns1:PV_PXPIDREF>
            {
                for $IDTXNT24 in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/IDTXNT24
                return
                    <ns1:PV_REFTRANSACCIONT24>
                        {
                            if (empty(data($IDTXNT24))) then
                                ('')
                            else 
                                data($IDTXNT24)
                        }
					</ns1:PV_REFTRANSACCIONT24>
            }
            <ns1:PV_ESTADOPROCESO>{ $estadoProceso }</ns1:PV_ESTADOPROCESO>
            <ns1:PV_CODIGOERRORPROCESO>{ $codigoErrorProceso }</ns1:PV_CODIGOERRORPROCESO>
            <ns1:PV_MENSAJEERRORPROCESO>{ $mensajeErrorProceso }</ns1:PV_MENSAJEERRORPROCESO>
            <ns1:PV_RESULTPXP>{ $pxpResult }</ns1:PV_RESULTPXP>
            <ns1:PV_ERRORCODEPXP>{ $pxpErrorCode }</ns1:PV_ERRORCODEPXP>
            {
                for $ACCTSHORTTITLE in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/ACCTSHORTTITLE
                return
                    <ns1:PV_NOMBREORDENANTE>{ data($ACCTSHORTTITLE) }</ns1:PV_NOMBREORDENANTE>
            }
        </ns1:InputParameters>
};

declare variable $consultaDatosACHEnviadoResponse as element(ns0:ConsultaDatosACHEnviadoResponse) external;
declare variable $achSecuencia as xs:string external;
declare variable $codigoProceso as xs:string external;
declare variable $refControlT24 as xs:string external;
declare variable $pxpIdRef as xs:string external;
declare variable $estadoProceso as xs:string external;
declare variable $codigoErrorProceso as xs:string external;
declare variable $mensajeErrorProceso as xs:string external;
declare variable $pxpResult as xs:string external;
declare variable $pxpErrorCode as xs:string external;

xf:actualizaRegistroACHEnviadoIn($consultaDatosACHEnviadoResponse,
    $achSecuencia,
    $codigoProceso,
    $refControlT24,
    $pxpIdRef,
    $estadoProceso,
    $codigoErrorProceso,
    $mensajeErrorProceso,
    $pxpResult,
    $pxpErrorCode)

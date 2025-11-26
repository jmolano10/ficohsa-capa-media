(:: pragma bea:global-element-parameter parameter="$opSuspensionChequesRespuesta" element="ns3:opSuspensionChequesRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:suspensionChequesResponse" location="../xsd/suspensionChequesTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/suspensionChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuspensionCheques/xq/suspensionChequesNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function motive ($item as item()) as xs:string {
	let $motive:=fn-bea:trim(upper-case(fn:string($item/text())))
	return
		if ($motive = 'P')  then (
			'LOST'
		) else if ($motive = 'R') then(
			'STOLEN'
		)else('')
};

declare function xf:suspensionChequesNIOut($opSuspensionChequesRespuesta as element(ns3:opSuspensionChequesRespuesta))
    as element(ns1:suspensionChequesResponse) {
        <ns1:suspensionChequesResponse>
            {
                for $generalStatus in $opSuspensionChequesRespuesta/ns0:statusCheque[1]/ns0:status
                return
                    <STATUS>{ xs:string(data($generalStatus)) }</STATUS>
            }
            {
                for $generalStatusDesc in $opSuspensionChequesRespuesta/ns0:statusCheque[1]/ns0:descStatus
                return
                    <STATUS_DESC>{ data($generalStatusDesc) }</STATUS_DESC>
            }
            <CHEQUES>
                {
                    for $cheque in $opSuspensionChequesRespuesta/ns0:cheque
                    return
                        <CHEQUE>
                            {
                                for $numeroCheque in $cheque/ns0:numeroCheque
                                return
                                    <CHEQUE_NUMBER>{ data($numeroCheque) }</CHEQUE_NUMBER>
                            }
                            {
                                for $status in $cheque/ns0:status
                                return
                                    <STATUS>{ data($status) }</STATUS>
                            }
                            {
                                for $descStatus in $cheque/ns0:descStatus
                                return
                                    <STATUS_DESC>{ data($descStatus) }</STATUS_DESC>
                            }
                            {
                                for $motivo in $cheque/ns0:motivo
                                return
                                    <MOTIVE>{ motive($motivo) }</MOTIVE>
                            }
                        </CHEQUE>
                }
            </CHEQUES>
        </ns1:suspensionChequesResponse>
};

declare variable $opSuspensionChequesRespuesta as element(ns3:opSuspensionChequesRespuesta) external;

xf:suspensionChequesNIOut($opSuspensionChequesRespuesta)

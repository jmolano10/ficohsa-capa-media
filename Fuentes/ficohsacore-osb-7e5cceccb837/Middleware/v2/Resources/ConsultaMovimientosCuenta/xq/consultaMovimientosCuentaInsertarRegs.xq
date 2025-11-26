(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns1:ConsultaMovimientosCuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/insertarMovimientosCuenta/xsd/insertarMovimientosCuenta_sp.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaInsertarRegs/";

declare function xf:consultaMovimientosCuentaInsertarRegs($consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse),
    $TicketOSB as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TICKETOSB>{ $TicketOSB }</ns0:PV_TICKETOSB>
            {
                <ns0:PT_CODIGOUSUARIO>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $INPUTTER in $mWSACCOUNTENTRIESDetailType/INPUTTER
                                    return
                                        <ns0:ITEM>{ data($INPUTTER) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_CODIGOUSUARIO>             
            }
            {
                <ns0:PT_SECUENCIAMOVIMIENTO>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM>{ data($TXNREFERENCE) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_SECUENCIAMOVIMIENTO> 
            }
            {
                <ns0:PT_FECHA>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDATETIME in $mWSACCOUNTENTRIESDetailType/TXNDATETIME
                                    return
                                        <ns0:ITEM>{ data($TXNDATETIME) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_FECHA>             
            }         
            {
                <ns0:PT_NUMEROCUENTA>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM>{ data($consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACCOUNTNUMBER) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_NUMEROCUENTA>             
            }
            {
                <ns0:PT_CODIGOTIPOTRANSACCION>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNCODE in $mWSACCOUNTENTRIESDetailType/TXNCODE
                                    return
                                        <ns0:ITEM>{ data($TXNCODE) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_CODIGOTIPOTRANSACCION>             
            }                             
            {
                <ns0:PT_NUMERODOCUMENTO>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $CHEQUENUMBER in $mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
                                    return
                                        <ns0:ITEM>{ data($CHEQUENUMBER) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_NUMERODOCUMENTO>             
            }
            {
                <ns0:PT_AGENCIAORIGEN>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNAGNCODE in $mWSACCOUNTENTRIESDetailType/TXNAGNCODE
                                    return
                                        <ns0:ITEM>{ data($TXNAGNCODE) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_AGENCIAORIGEN>             
            }
            {
                <ns0:PT_NOMBREAGENCIA>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNAGNNAME in $mWSACCOUNTENTRIESDetailType/TXNAGNNAME
                                    return
                                        <ns0:ITEM>{ data($TXNAGNNAME) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_NOMBREAGENCIA>             
            }
            {
                <ns0:PT_CODIGOAUTORIZADOR>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $AUTHORISER in $mWSACCOUNTENTRIESDetailType/AUTHORISER
                                    return
                                        <ns0:ITEM>{ data($AUTHORISER) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_CODIGOAUTORIZADOR>             
            }
            {
                <ns0:PT_NUMEROAUTORIZACION>
                 {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM></ns0:ITEM>                            
                    return
                        $result
                 }                
                </ns0:PT_NUMEROAUTORIZACION>             
            }
            {
                <ns0:PT_FECHAVALIDA>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $BOOKINGDATE in $mWSACCOUNTENTRIESDetailType/BOOKINGDATE
                                    return
                                        <ns0:ITEM>{ data($BOOKINGDATE) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_FECHAVALIDA>             
            }
            {
                <ns0:PT_MONTO>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return                                   
                                    for $i in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                       let $dAmount := $mWSACCOUNTENTRIESDetailType/DAMOUNT
            	                       let $cAmount := $mWSACCOUNTENTRIESDetailType/CAMOUNT
                                       return 
                                        <ns0:ITEM>
                                        {
	                                        if ($cAmount[$i] = "0.00") then (
				                        		data($dAmount[$i])
				                        	) else (
				                        		data($cAmount[$i])
				                        	)   
                                        }
                                        </ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_MONTO>             
            }  
            {
                <ns0:PT_DESCRIPCION>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDESCRIPTION in $mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
                                    return
                                        <ns0:ITEM>{ data($TXNDESCRIPTION) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_DESCRIPCION>             
            }  
            {
                <ns0:PT_DESCRIPCIONCLIENTE>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDESCRIPTIONALL in $mWSACCOUNTENTRIESDetailType/TXNDESCRIPTIONALL
                                    return
                                        <ns0:ITEM>{ data($TXNDESCRIPTIONALL) }</ns0:ITEM>                            
                    return
                        $result
                 }
                </ns0:PT_DESCRIPCIONCLIENTE>             
            }                                 
            {
                <ns0:PT_TIPOCOMISION>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM></ns0:ITEM>                            
                    return
                        $result
                 }                
                </ns0:PT_TIPOCOMISION>             
            } 
            {
                <ns0:PT_SECUENCIAMOVIMIENTOTFS>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM></ns0:ITEM>                            
                    return
                        $result
                 }                 
                </ns0:PT_SECUENCIAMOVIMIENTOTFS>             
            } 
            {
                <ns0:PT_MONTOCOMISION>
                {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns0:ITEM></ns0:ITEM>                            
                    return
                        $result
                 }                 
                </ns0:PT_MONTOCOMISION>             
            }
        </ns0:InputParameters>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse) external;
declare variable $TicketOSB as xs:string external;

xf:consultaMovimientosCuentaInsertarRegs($consultaMovimientosCuentaResponse1,
    $TicketOSB)

xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/AccountInquiryT24/XMLSchema_378991004.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/InsertMovementsAccount";
(:: import schema at "../../../../ProviderServices/XSD/InsertMovementsAccount/InsertMovementsAccount_sp.xsd" ::)

declare variable $GetAccountMovementsResponse as element() (:: schema-element(ns1:ConsultaMovimientosCuentaResponse) ::) external;
declare variable $TicketOSB as xs:string external;

declare function local:func($GetAccountMovementsResponse as element() (:: schema-element(ns1:ConsultaMovimientosCuentaResponse) ::), 
                            $TicketOSB as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_TICKETOSB>{fn:data($TicketOSB)}</ns2:PV_TICKETOSB>
        <ns2:PT_CODIGOUSUARIO>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $INPUTTER in $mWSACCOUNTENTRIESDetailType/INPUTTER
                                    return
                                        <ns2:PT_CODIGOUSUARIO_ITEM>{ data($INPUTTER) }</ns2:PT_CODIGOUSUARIO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_CODIGOUSUARIO>
        <ns2:PT_SECUENCIAMOVIMIENTO>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_SECUENCIAMOVIMIENTO_ITEM>{ data($TXNREFERENCE) }</ns2:PT_SECUENCIAMOVIMIENTO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_SECUENCIAMOVIMIENTO>
        <ns2:PT_FECHA>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDATETIME in $mWSACCOUNTENTRIESDetailType/TXNDATETIME
                                    return
                                        <ns2:PT_CODIGOUSUARIO_ITEM>{ data($TXNDATETIME) }</ns2:PT_CODIGOUSUARIO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_FECHA>
        <ns2:PT_NUMEROCUENTA>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_NUMEROCUENTA_ITEM>{ data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ACCOUNTNUMBER) }</ns2:PT_NUMEROCUENTA_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_NUMEROCUENTA>
        <ns2:PT_CODIGOTIPOTRANSACCION>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNCODE in $mWSACCOUNTENTRIESDetailType/TXNCODE
                                    return
                                        <ns2:PT_NUMEROCUENTA_ITEM>{ data($TXNCODE) }</ns2:PT_NUMEROCUENTA_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_CODIGOTIPOTRANSACCION>
        <ns2:PT_NUMERODOCUMENTO>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $CHEQUENUMBER in $mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
                                    return
                                        <ns2:PT_SECUENCIAMOVIMIENTO_ITEM>{ data($CHEQUENUMBER) }</ns2:PT_SECUENCIAMOVIMIENTO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_NUMERODOCUMENTO>
        <ns2:PT_AGENCIAORIGEN>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNAGNCODE in $mWSACCOUNTENTRIESDetailType/TXNAGNCODE
                                    return
                                        <ns2:PT_NUMEROCUENTA_ITEM>{ data($TXNAGNCODE) }</ns2:PT_NUMEROCUENTA_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_AGENCIAORIGEN>
        <ns2:PT_NOMBREAGENCIA>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNAGNNAME in $mWSACCOUNTENTRIESDetailType/TXNAGNNAME
                                    return
                                        <ns2:PT_NOMBREAGENCIA_ITEM>{ data($TXNAGNNAME) }</ns2:PT_NOMBREAGENCIA_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_NOMBREAGENCIA>
        <ns2:PT_CODIGOAUTORIZADOR>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $AUTHORISER in $mWSACCOUNTENTRIESDetailType/AUTHORISER
                                    return
                                        <ns2:PT_CODIGOUSUARIO_ITEM>{ data($AUTHORISER) }</ns2:PT_CODIGOUSUARIO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_CODIGOAUTORIZADOR>
        <ns2:PT_NUMEROAUTORIZACION>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_NUMEROCUENTA_ITEM></ns2:PT_NUMEROCUENTA_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_NUMEROAUTORIZACION>
        <ns2:PT_FECHAVALIDA>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $BOOKINGDATE in $mWSACCOUNTENTRIESDetailType/BOOKINGDATE
                                    return
                                        <ns2:PT_CODIGOUSUARIO_ITEM>{ data($BOOKINGDATE) }</ns2:PT_CODIGOUSUARIO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_FECHAVALIDA>
        <ns2:PT_MONTO>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return                                   
                                    for $i in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                       let $dAmount := $mWSACCOUNTENTRIESDetailType/DAMOUNT
            	                       let $cAmount := $mWSACCOUNTENTRIESDetailType/CAMOUNT
                                       return 
                                        <ns2:PT_MONTO_ITEM>
                                        {
	                                        if ($cAmount[$i] = "0.00") then (
				                        		data($dAmount[$i])
				                        	) else (
				                        		data($cAmount[$i])
				                        	)   
                                        }
                                        </ns2:PT_MONTO_ITEM>                           
                    return
                        $result
                 }
        </ns2:PT_MONTO>
        <ns2:PT_DESCRIPCION>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDESCRIPTION in $mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
                                    return
                                        <ns2:PT_DESCRIPCION_ITEM>{ data($TXNDESCRIPTION) }</ns2:PT_DESCRIPCION_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_DESCRIPCION>
        <ns2:PT_DESCRIPCIONCLIENTE>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNDESCRIPTIONALL in $mWSACCOUNTENTRIESDetailType/TXNDESCRIPTIONALL
                                    return
                                        <ns2:PT_DESCRIPCIONCLIENTE_ITEM>{ data($TXNDESCRIPTIONALL) }</ns2:PT_DESCRIPCIONCLIENTE_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_DESCRIPCIONCLIENTE>
        <ns2:PT_TIPOCOMISION>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_TIPOCOMISION_ITEM></ns2:PT_TIPOCOMISION_ITEM>                           
                    return
                        $result
                 }
        </ns2:PT_TIPOCOMISION>
        <ns2:PT_SECUENCIAMOVIMIENTOTFS>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_SECUENCIAMOVIMIENTO_ITEM></ns2:PT_SECUENCIAMOVIMIENTO_ITEM>                            
                    return
                        $result
                 }
        </ns2:PT_SECUENCIAMOVIMIENTOTFS>
        <ns2:PT_MONTOCOMISION>
            {
                    let $result :=
                        for $mWSACCOUNTENTRIESDetailType in $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType
                        return
                                    for $TXNREFERENCE in $mWSACCOUNTENTRIESDetailType/TXNREFERENCE
                                    return
                                        <ns2:PT_MONTO_ITEM></ns2:PT_MONTO_ITEM>                           
                    return
                        $result
                 }
        </ns2:PT_MONTOCOMISION>
    </ns2:InputParameters>
};

local:func($GetAccountMovementsResponse, $TicketOSB)
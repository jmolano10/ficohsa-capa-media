(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns1:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaAbanksDetalladoIn/";

declare function xf:consultaMovimientosCuentaAbanksDetalladoIn($consultaMovimientosCuenta1 as element(ns1:consultaMovimientosCuenta),
    $fechaT24 as xs:string,
    $CuentaAbanks as xs:string,
    $ticketOSB as xs:string,
    $nombreCuenta as xs:string,
    $monedaCuenta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ACCOUNTNUMBER>{ $CuentaAbanks }</ns0:PV_ACCOUNTNUMBER>
            <ns0:PV_BEGINDATE>{ data($consultaMovimientosCuenta1/BEGIN_DATE) }</ns0:PV_BEGINDATE>
            <ns0:PV_ENDDATE>
                {
                    if ($fechaT24 != "") then
                        ($fechaT24)
                    else 
                        data($consultaMovimientosCuenta1/END_DATE)
                }
</ns0:PV_ENDDATE>
            <ns0:PN_INITIALRECORD>{ xs:string($consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD) }</ns0:PN_INITIALRECORD>
            <ns0:PN_RECORDCOUNT>{ xs:string($consultaMovimientosCuenta1/PAGING_INFO/RECORD_COUNT) }</ns0:PN_RECORDCOUNT>
            <ns0:PV_TICKETOSB>{ $ticketOSB }</ns0:PV_TICKETOSB>
            <ns0:PT_TYPEFILTER>
				{
				    for $FILTER_CRITERIA in $consultaMovimientosCuenta1/FILTER_CRITERIAS/FILTER_CRITERIA
                        return
						for $TYPE_FILTER in $FILTER_CRITERIA/TYPE_FILTER
                            return
							<ns0:ITEM>{ data($TYPE_FILTER) }</ns0:ITEM>
				}
			</ns0:PT_TYPEFILTER>
        
			<ns0:PT_VALUEFILTER>
				{ 
					for $FILTER_CRITERIA in $consultaMovimientosCuenta1/FILTER_CRITERIAS/FILTER_CRITERIA
						return
						for $VALUE_FILTER in $FILTER_CRITERIA/VALUE_FILTER
                            return
                                <ns0:ITEM>{ data($VALUE_FILTER) }</ns0:ITEM>
				}
			</ns0:PT_VALUEFILTER>
        
			
            <ns0:PV_ACCOUNTNAME>{ $nombreCuenta }</ns0:PV_ACCOUNTNAME>
            <ns0:PV_CURRENCY>{ $monedaCuenta }</ns0:PV_CURRENCY>
        </ns0:InputParameters>
};

declare variable $consultaMovimientosCuenta1 as element(ns1:consultaMovimientosCuenta) external;
declare variable $fechaT24 as xs:string external;
declare variable $CuentaAbanks as xs:string external;
declare variable $ticketOSB as xs:string external;
declare variable $nombreCuenta as xs:string external;
declare variable $monedaCuenta as xs:string external;

xf:consultaMovimientosCuentaAbanksDetalladoIn($consultaMovimientosCuenta1,
    $fechaT24,
    $CuentaAbanks,
    $ticketOSB,
    $nombreCuenta,
    $monedaCuenta)

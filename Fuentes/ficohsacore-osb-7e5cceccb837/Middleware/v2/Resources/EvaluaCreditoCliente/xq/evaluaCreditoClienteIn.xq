(:: pragma bea:global-element-parameter parameter="$evaluaCreditoClienteRequest1" element="ns1:evaluaCreditoClienteRequest" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ePOriginacion" location="../../../BusinessServices/BLAZE/wsdl/originacionesGT.wsdl" ::)

declare namespace ns0 = "http://webservices.alcance.com.hn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/evaluaCreditoClienteIn/";

declare function xf:evaluaCreditoClienteIn($evaluaCreditoClienteRequest1 as element(ns1:evaluaCreditoClienteRequest))
    as element(ns0:epOriginacion) {
        <ns0:epOriginacion>
            <arg0>
                <accion>
                    <limiteAsignado>{ data($evaluaCreditoClienteRequest1/ASSIGNED_LIMIT) }</limiteAsignado>
                    <montoPtmoFidu>{ data($evaluaCreditoClienteRequest1/LOAN_AMOUNT) }</montoPtmoFidu>
                    <productoSugerido>{ data($evaluaCreditoClienteRequest1/SUGGESTED_PRODUCT) }</productoSugerido>
                    <tasaPtmoFidut>{ data($evaluaCreditoClienteRequest1/LOAN_RATE) }</tasaPtmoFidut>
                </accion>
                <antiguedadReferenciaValida>{ data($evaluaCreditoClienteRequest1/REFERENCE_VALID_TIME) }</antiguedadReferenciaValida>
                {
                    for $BUREAU in $evaluaCreditoClienteRequest1/BUREAUS/BUREAU
                    return
                        <buro>
                            <buroScore>{ data($BUREAU/SCORE_BURO) }</buroScore>
                            {
                                for $QUERIES in $BUREAU/QUERIES,
                                    $QUERY in $QUERIES/QUERY
                                return
                                    <consultas>
                                        {
                                            for $ENTITY in $QUERY/ENTITY
                                            return
                                                <entidad>{ data($ENTITY) }</entidad>
                                        }
                                        {
                                            for $DATE in $QUERY/DATE
                                            return
                                                <fecha>{ data($QUERY/DATE) }</fecha>
                                        }
                                        
                                        {
                                            for $MOTIVE in $QUERY/MOTIVE
                                            return
                                                <motivo>{ data($MOTIVE) }</motivo>
                                        }
                                        {
                                            for $ID in $QUERY/ID
                                            return
                                                <numeroEvaluacion>{ data($ID) }</numeroEvaluacion>
                                        }
                                        <tipoConsulta>{ data($QUERY/TYPE) }</tipoConsulta>
                                    </consultas>
                            }
                            {
                                for $NAME in $BUREAU/NAME
                                return
                                    <nombre>{ data($NAME) }</nombre>
                            }
                            {
                                for $REFERENCE in $BUREAU/REFERENCES/REFERENCE
                                return
                                    <referencia>
                                        {
			                                for $calification in $REFERENCE/FIELD[NAME='CALIFICATION']/VALUE
			                                return
			                                    <calificacion>{ data($calification) }</calificacion>
			                            }
			                            {
			                                for $categoria in $REFERENCE/FIELD[NAME='CATEGORY']/VALUE
			                                return
			                                    <categoria>{ data($categoria) }</categoria>
			                            }
			                            {
			                                for $codigoObligacion in $REFERENCE/FIELD[NAME='LIABILITY_CODE']/VALUE
			                                return
			                                    <codigoObligacion>{ data($codigoObligacion) }</codigoObligacion>
			                            }
			                            {
			                                for $comportamiento in $REFERENCE/FIELD[NAME='BEHAVIOR']/VALUE
			                                return
			                                    <comportamiento>{ data($comportamiento) }</comportamiento>
			                            }
			                            {
			                                for $cuota in $REFERENCE/FIELD[NAME='QUOTE']/VALUE
			                                return
			                                    <cuota>{ data($cuota) }</cuota>
			                            }
			                            {
			                                for $entidad in $REFERENCE/FIELD[NAME='ENTITY']/VALUE
			                                return
			                                    <entidad>{ data($entidad) }</entidad>
			                            }
			                            {
			                                for $estadoCredito in $REFERENCE/FIELD[NAME='CREDIT_STATUS']/VALUE
			                                return
			                                    <estadoCredito>{ data($estadoCredito) }</estadoCredito>
			                            }
			                            {
			                                for $estatus in $REFERENCE/FIELD[NAME='STATUS']/VALUE
			                                return
			                                    <estatus>{ data($estatus) }</estatus>
			                            }
			                            {
			                                for $fechaActivo in $REFERENCE/FIELD[NAME='ASSET_DATE']/VALUE
			                                return
			                                    <fechaActivo>{ data($fechaActivo) }</fechaActivo>
			                            }
			                            {
			                                for $fechaActualizacion in $REFERENCE/FIELD[NAME='UPDATE_DATE']/VALUE
			                                return
			                                    <fechaActualizacion>{ data($fechaActualizacion) }</fechaActualizacion>
			                            }
			                            {
			                                for $fechaApertura in $REFERENCE/FIELD[NAME='OPENING_DATE']/VALUE
			                                return
			                                    <fechaApertura>{ data($fechaApertura) }</fechaApertura>
			                            }
			                            {
			                                for $fechaCancelacion in $REFERENCE/FIELD[NAME='CANCELLATION_DATE']/VALUE
			                                return
			                                    <fechaCancelacion>{ data($fechaCancelacion) }</fechaCancelacion>
			                            }
			                            {
			                                for $fechaVencimiento in $REFERENCE/FIELD[NAME='DUE_DATE']/VALUE
			                                return
			                                    <fechaVencimiento>{ data($fechaVencimiento) }</fechaVencimiento>
			                            }
			                            {
			                                for $IDEvaluacion in $REFERENCE/FIELD[NAME='EVALUATION_ID']/VALUE
			                                return
			                                    <IDEvaluacion>{ data($IDEvaluacion) }</IDEvaluacion>
			                            }
			                            {
			                                for $limiteCredito in $REFERENCE/FIELD[NAME='CREDIT_LIMIT']/VALUE
			                                return
			                                    <limiteCredito>{ data($limiteCredito) }</limiteCredito>
			                            }
			                            {
			                                for $moneda in $REFERENCE/FIELD[NAME='CURRENCY']/VALUE
			                                return
			                                    <moneda>{ data($moneda) }</moneda>
			                            }
			                            {
			                                for $numeroEvaluacion in $REFERENCE/FIELD[NAME='EVALUATION_NUMBER']/VALUE
			                                return
			                                    <numeroEvaluacion>{ data($numeroEvaluacion) }</numeroEvaluacion>
			                            }
			                            {
			                                for $periodoPago in $REFERENCE/FIELD[NAME='PAYMENT_PERIOD']/VALUE
			                                return
			                                    <periodoPago>{ data($periodoPago) }</periodoPago>
			                            }
			                            {
			                                for $saldoActual in $REFERENCE/FIELD[NAME='ACTUAL_BALANCE']/VALUE
			                                return
			                                    <saldoActual>{ data($saldoActual) }</saldoActual>
			                            }
			                            {
			                                for $saldoMora in $REFERENCE/FIELD[NAME='LATE_FEE']/VALUE
			                                return
			                                    <saldoMora>{ data($saldoMora) }</saldoMora>
			                            }
			                            {
			                                for $sectorObligacion in $REFERENCE/FIELD[NAME='SECTOR']/VALUE
			                                return
			                                    <sectorObligacion>{ data($sectorObligacion) }</sectorObligacion>
			                            }
			                            {
			                                for $tipoActivo in $REFERENCE/FIELD[NAME='ASSET_TYPE']/VALUE
			                                return
			                                    <tipoActivo>{ data($tipoActivo) }</tipoActivo>
			                            }
			                            {
			                                for $tipoGarantia in $REFERENCE/FIELD[NAME='WARRANTY_TYPE']/VALUE
			                                return
			                                    <tipoGarantia>{ data($tipoGarantia) }</tipoGarantia>
			                            }
			                            {
			                                for $tipoObligacion in $REFERENCE/FIELD[NAME='LIABILITY_TYPE']/VALUE
			                                return
			                                    <tipoObligacion>{ data($tipoObligacion) }</tipoObligacion>
			                            }
			                            {
			                                for $tipoReferencia in $REFERENCE/FIELD[NAME='REFERENCE_TYPE']/VALUE
			                                return
			                                    <tipoReferencia>{ data($tipoReferencia) }</tipoReferencia>
			                            }
			                            {
			                                for $ultMovAno in $REFERENCE/FIELD[NAME='LAST_YEAR_MOVEMENT']/VALUE
			                                return
			                                    <ultMovAno>{ data($ultMovAno) }</ultMovAno>
			                            }
			                            {
			                                for $ultMovMes in $REFERENCE/FIELD[NAME='LAST_MONTH_MOVEMENT']/VALUE
			                                return
			                                    <ultMovMes>{ data($ultMovMes) }</ultMovMes>
			                            }
                                    </referencia>
                            }
                        </buro>
                }
                <entidadReferenciaValida>{ data($evaluaCreditoClienteRequest1/VALID_REFERENCE_TYPE) }</entidadReferenciaValida>
                <fecha_aplicacion>{ xs:date(data($evaluaCreditoClienteRequest1/APPLICATION_DATE)) }</fecha_aplicacion>
                <fecha_nacimiento>{ xs:date(data($evaluaCreditoClienteRequest1/DATE_OF_BIRTH)) }</fecha_nacimiento>
                <flagHitSinRefs>{ data($evaluaCreditoClienteRequest1/FLAG_HIT_SIN_REFS) }</flagHitSinRefs>
                <flagNoHit>{ data($evaluaCreditoClienteRequest1/FLAG_NO_HIT) }</flagNoHit>
                <flagSirc>{ data($evaluaCreditoClienteRequest1/FLAG_SIRC) }</flagSirc>
                <identidad>{ data($evaluaCreditoClienteRequest1/CUSTOMER_ID) }</identidad>
                <ingresosMensuales>{ data($evaluaCreditoClienteRequest1/MONTHLY_INCOME) }</ingresosMensuales>
                <limiteMaxTarjeta>{ data($evaluaCreditoClienteRequest1/MAX_CREDIT_CARD_LIMIT) }</limiteMaxTarjeta>
                <montoMaximoBanca>{ data($evaluaCreditoClienteRequest1/MAX_BANK_AMOUNT) }</montoMaximoBanca>
                <montoMaximoComercio>{ data($evaluaCreditoClienteRequest1/MAX_COMMERCE_AMOUNT) }</montoMaximoComercio>
                {
                    for $ID in $evaluaCreditoClienteRequest1/ID
                    return
                        <numeroEvaaluacion>{ data($ID) }</numeroEvaaluacion>
                }
                <rechazoSIRC>{ data($evaluaCreditoClienteRequest1/PRE_REJECTED) }</rechazoSIRC>
                <scoreHit>{ data($evaluaCreditoClienteRequest1/SCORE_HIT) }</scoreHit>
                <scoreNoHit>{ data($evaluaCreditoClienteRequest1/SCORE_NO_HIT) }</scoreNoHit>
                <sexo>
                    {
                        if (fn:string($evaluaCreditoClienteRequest1/GENDER/text()) = "M") then
                            (1)
                        else 
                            2
                    }
</sexo>
                <tiempoResidenciaMeses>{ data($evaluaCreditoClienteRequest1/RESIDENCE_TIME) }</tiempoResidenciaMeses>
                <tipoReferenciaValida>{ data($evaluaCreditoClienteRequest1/PRE_REJECTED) }</tipoReferenciaValida>
                <tipoVivienda>{ data($evaluaCreditoClienteRequest1/HOUSING_TYPE) }</tipoVivienda>
                <tipo_cambio>{ data($evaluaCreditoClienteRequest1/EXCHANGE_RATE) }</tipo_cambio>
            </arg0>
        </ns0:epOriginacion>
};

declare variable $evaluaCreditoClienteRequest1 as element(ns1:evaluaCreditoClienteRequest) external;

xf:evaluaCreditoClienteIn($evaluaCreditoClienteRequest1)


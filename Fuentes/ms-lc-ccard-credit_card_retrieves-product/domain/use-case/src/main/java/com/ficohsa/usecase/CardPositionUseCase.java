package com.ficohsa.usecase;

import com.ficohsa.helper.RegionUtils;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.model.cardposition.Region;
import com.ficohsa.ports.ICardPosition;
import com.ficohsa.ports.IHistoryInfoTransactionsGateway;
import com.ficohsa.ports.IHistoryTransactionsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import com.ficohsa.usecase.service.cardposition.mapper.CreditCardStatementMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Optional;
import java.util.regex.Pattern;

@Slf4j
@Component
@RequiredArgsConstructor
public class CardPositionUseCase implements ICardPosition {

    private final IHistoryInfoTransactionsGateway historyInfoTransactionsGateway;
    private final IHistoryTransactionsGateway historyTransactionsGateway;
    private final IRegionalizationGateway regionalizationGateway;

    @Override
    public Mono<CreditCardStatement> rtvCardPosition(String creditCardId, String srcRg, String dstRg) {
        return Mono.fromCallable(() -> validateCreditCard(creditCardId))
                .flatMap(cardId -> {
                    Region rg = new Region(srcRg, dstRg);
                    String regionKey = rg.getJoined();
                    return regionalizationGateway.validateRegion("card-position/retrieve", srcRg, dstRg)
                            .then(Mono.defer(() ->
                                    historyInfoTransactionsGateway.rtvHistoryInfoTc(creditCardId, regionKey)
                                            .flatMap(infoHis -> historyTransactionsGateway.rtvHistoryTc(creditCardId, regionKey, "1")
                                                    .map(infoTx -> {
                                                        String localCurrency = RegionUtils.getLocalCurrency(regionKey);
                                                        return CreditCardStatementMapper.merge(infoHis, infoTx, localCurrency);
                                                    })
                                            )
                            ));
                });
    }

    private String validateCreditCard(String creditCardId) {
        Pattern pattern = Pattern.compile("^.+$");
        return Optional.ofNullable(creditCardId)
                .filter(cardId -> pattern.matcher(cardId).matches())
                .orElseThrow(() -> new UnprocessableEntityException("Invalid credit card ID"));
    }
}

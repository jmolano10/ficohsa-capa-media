package com.ficohsa.model.debitbasicinformation;

import java.util.List;

public record LinkedAccounts(
        List<DebitAccounts> primaryAccounts,
        List<DebitAccounts> secondaryAccounts
) {
}

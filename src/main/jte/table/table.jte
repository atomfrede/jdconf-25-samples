@import com.github.atomfrede.jdconf_sample.person.Person
@import com.github.atomfrede.jdconf_sample.pagination.PagerModel
@import org.springframework.data.domain.Page
@import gg.jte.support.ForSupport
@import java.util.Locale

@param Page<Person> persons
@param PagerModel pager

<table hx-target="#table-wrapper" hx-push-url="true" class="striped">
    <thead>
    <tr>
        <th scope="col">
            <div>
                Name
            </div>
        </th>
        <th scope="col">Quote</th>
    </tr>
    </thead>
    <tbody>
    @for(var personEntry : ForSupport.of(persons.getContent()))
        <tr>
            <th scope="row">${personEntry.get().getName()}</th>
            <td>${personEntry.get().getQuote()}</td>
        </tr>
    @endfor
    </tbody>
</table>

<div role="group" hx-target="#table-wrapper" hx-push-url="true">
    @if (persons.hasPrevious())
        <button
                hx-get="/tables?size=${persons.getPageable().getPageSize()}&sort=${persons.getPageable().getSort().toString().replace(": ", ",").trim().toLowerCase(Locale.ROOT)}&page=${persons.getPageable().getPageNumber()-1}"
        >Prev
        </button>
    @else
        <button disabled>Prev</button>
    @endif

    @if (persons.getPageable().getPageNumber() + 1 - pager.getButtonsToShow() >=1)
        <button
                hx-get="/tables?size=${persons.getPageable().getPageSize()}&sort=${persons.getPageable().getSort().toString().replace(": ", ",").trim().toLowerCase(Locale.ROOT)}&page=${persons.getPageable().getPageNumber()-pager.getButtonsToShow()}"
        >...
        </button>
    @endif

    @for(int i = pager.getStartPage(); i<=pager.getEndPage(); i++)
        <button
                hx-get="/tables?size=${persons.getPageable().getPageSize()}&sort=${persons.getPageable().getSort().toString().replace(": ", ",").trim().toLowerCase(Locale.ROOT)}&page=${i}"
        >
            ${i}
        </button>
    @endfor

    @if (persons.getPageable().getPageNumber() + 1 + pager.getButtonsToShow() <= persons.getTotalPages())
        <button
                hx-get="/tables?size=${persons.getPageable().getPageSize()}&sort=${persons.getPageable().getSort().toString().replace(": ", ",").trim().toLowerCase(Locale.ROOT)}&page=${persons.getPageable().getPageNumber()+pager.getButtonsToShow()}"

        >...
        </button>
    @endif

    @if (persons.hasNext())
        <button
                hx-get="/tables?size=${persons.getPageable().getPageSize()}&sort=${persons.getPageable().getSort().toString().replace(": ", ",").trim().toLowerCase(Locale.ROOT)}&page=${persons.getPageable().getPageNumber()+1}"

        >Next
        </button>
    @else
        <button disabled>Next</button>
    @endif
</div>
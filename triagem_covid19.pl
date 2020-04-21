%Fatos
paciente(jose).
paciente(maria).

idade(jose, 60).
idade(maria, 61).

qtd_comorbidades(jose, 2).
qtd_comorbidades(maria, 1).

temperatura(jose, 34).
temperatura(maria, 37).

freq_cardiaca(jose, 90).
freq_cardiaca(maria, 100).

freq_respiratoria(jose, 17).
freq_respiratoria(maria, 20).

pa_sistolica(jose, 90).
pa_sistolica(maria, 95).

sao2(jose, 99).
sao2(maria, 99).

dispneia(jose, "Sim").
dispneia(maria, "N�o").


%Regras
temperatura_leve_medio(T):-
    T < 35;
    (T >= 37,T < 39).

pa_sistolica_leve_medio(PA):-
    PA >= 90,
    PA =< 100.

freq_respiratoria_leve_medio(FR):-
    FR >= 19,
    FR =< 30.

paciente_grave(P):-
    (   freq_respiratoria(P, FREQ_RESP), FREQ_RESP > 30);
    (   pa_sistolica(P, PA_SISTOLICA), PA_SISTOLICA < 90);
    (   sao2(P, SAO2), SAO2 < 95);
    (   dispneia(P, DISPNEIA), DISPNEIA = "Sim").

paciente_leve_medio(P):-
    (   temperatura(P, TEMPERATURA), temperatura_leve_medio(TEMPERATURA));
    (   freq_cardiaca(P, FREQ_CARD), FREQ_CARD > 100);
    (   freq_respiratoria(P, FREQ_RESP), freq_respiratoria_leve_medio(FREQ_RESP));
    (   pa_sistolica(P, PA_SISTOLICA), pa_sistolica_leve_medio(PA_SISTOLICA));
    (   dispneia(P, DISPNEIA), DISPNEIA = "N�o");
    (   idade(P, IDADE), IDADE >= 60);
    (   qtd_comorbidades(P, QTD_COMORBIDADES),QTD_COMORBIDADES >= 1).

diagnostico_grave(P):-
    paciente_grave(P),
    write("Grave: deve ser encaminhado para o hospital").

diagnostico_leve_medio(P):-
    paciente_leve_medio(P),
    write("Leve/M�dio: deve ficar em casa, em observa��o por 14 dias.").

testar_paciente(P) :-
    diagnostico_grave(P);
    diagnostico_leve_medio(P).

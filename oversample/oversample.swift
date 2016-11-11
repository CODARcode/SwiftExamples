
global const string oversample_sh = "./oversample.sh";

app (file out, file log) oversample(string params[])
{
  oversample_sh out params @stdout=log;
}

params = [ "over_17/X", "over_17/y", "SMOTE", ".01" ];
file out<"out.txt">;
file log<"log.txt">;

(out, log) = oversample(params);

using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Globalization;
using System.Text;

namespace Procon32API.Utilities
{
    public class Answer
    {
        public Rotate[] Rotations;

        public Line[] Lines;

        public struct Line
        {
            public Point SelectPos;

            public Direction[] SwapDirections;
        }

        public enum Rotate
        {
            _0 = 0, _90 = 1, _180 = 2, _270 = 3
        }

        public enum Direction : byte
        {
            Up = (byte)'U', Down = (byte)'D', Left = (byte)'L', Right = (byte)'R'
        }
        
        public override string ToString()
        {
            return ToString("\r\n");
        }

        public string ToString(string newLine)
        {
            var sb = new StringBuilder();

            // 回転情報
            foreach (var rot in Rotations)
            {
                sb.Append((int)rot);
            }
            sb.Append(newLine);

            // 選択回数
            sb.Append(Lines.Length);
            sb.Append(newLine);

            // ライン
            foreach (var line in Lines)
            {
                // 選択画像位置
                sb.AppendFormat("{0:X}{1:X}", line.SelectPos.X, line.SelectPos.Y);
                sb.Append(newLine);

                // 交換回数
                sb.Append(line.SwapDirections.Length);
                sb.Append(newLine);

                // 交換操作
                foreach (var dir in line.SwapDirections)
                {
                    sb.Append((char)(byte)dir);
                }
                sb.Append(newLine);
            }

            return sb.ToString();
        }

        public static Answer Parse(string value)
        {
            return new Parser().Parse(value);
        }

        private class Parser
        {
            private static Regex Regex = new Regex(@"^[0-3]{1,256}\n\d{1,3}(\n[0-9|A-F]{2}\n\d+\n[UDRL]*)*", RegexOptions.Compiled);

            private int _cursor;

            private string[] _lines;

            public Answer Parse(string value)
            {
                // 改行コードにCRLFとLFを許容するためすべてLFに統一
                value = value.Replace("\r\n", "\n");

                // 正規表現で簡易チェック
                if (!Regex.IsMatch(value))
                {
                    throw new FormatException();
                }

                var result = new Answer();

                _cursor = 0;
                _lines = value.Split("\n");

                ParseRotations(out result.Rotations);

                var lineCnt = int.Parse(ReadNext());

                result.Lines = new Line[lineCnt];
                for (int i = 0; i < result.Lines.Length; i++)
                {
                    ParseLine(out result.Lines[i]);
                }

                return result;
            }

            private string ReadNext()
            {
                if (_cursor >= _lines.Length)
                {
                    throw new FormatException("回答の読み取り中に文字列の終端に達しました");
                }

                return _lines[_cursor++];
            }

            private void ParseRotations(out Rotate[] rotations)
            {
                string line = ReadNext();

                rotations = new Rotate[line.Length];

                for (int i = 0; i < line.Length; i++)
                {
                    char c = line[i];

                    rotations[i] = (Rotate)int.Parse($"{c}");
                }
            }

            private void ParseLine(out Line line)
            {
                string selectPosStr = ReadNext();
                int swapCnt = int.Parse(ReadNext());
                string swapStr = ReadNext();

                line = new Line()
                {
                    SelectPos = new Point(
                        int.Parse($"{selectPosStr[0]}", NumberStyles.HexNumber),
                        int.Parse($"{selectPosStr[1]}", NumberStyles.HexNumber)),
                    SwapDirections = new Direction[swapCnt]
                };

                for (int i = 0; i < line.SwapDirections.Length; i++)
                {
                    line.SwapDirections[i] = (Direction)(byte)swapStr[i];
                }
            }
        }
    }

    public class AnswerChecker
    {
        public Models.Subject Subject { get => _subject; }

        private Models.Subject _subject;

        public struct Result
        {
            /// <summary>
            /// 座標不一致枚数
            /// </summary>
            public int InvalidPosPeaceCnt;

            /// <summary>
            /// 向き不一致枚数
            /// </summary>
            public int InvalidRotPeaceCnt;

            /// <summary>
            /// 選択コスト
            /// </summary>
            public int TotalSelectionCost;

            /// <summary>
            /// 交換コスト
            /// </summary>
            public int TotalSwapCost;

            /// <summary>
            /// 総コスト
            /// </summary>
            public int TotalCost { get => TotalSelectionCost + TotalSwapCost; }
        }

        public AnswerChecker(Models.Subject subject)
        {
            _subject = subject;
        }

        public Result Check(Answer answer)
        {
            var result = new Result();

            // 課題情報から盤面を生成
            var firstDisp2Data = new Point[Subject.PeaceCount.X, Subject.PeaceCount.Y];
            for (int y = 0; y < Subject.Indexes.Length; y++)
            {
                var row = Subject.Indexes[y];

                for (int x = 0; x < row.Length; x++)
                {
                    firstDisp2Data[x, y] = new(
                        int.Parse($"{row[x][0]}", NumberStyles.HexNumber),
                        int.Parse($"{row[x][1]}", NumberStyles.HexNumber));
                }
            }
            var interDisp2Data = (Point[,])firstDisp2Data.Clone();

            result.TotalSelectionCost = Math.Min(answer.Lines.Length, Subject.MaxSelectCount) * Subject.SelectionCost;
            result.TotalSwapCost = 0;

            // 選択/交換を実行

            for (int y = 0; y < Subject.PeaceCount.Y; y++)
            {
                for (int x = 0; x < Subject.PeaceCount.X; x++)
                {
                    var pos = interDisp2Data[x, y];
                    Console.Write($"{pos.X:X}{pos.Y:X} ");
                }
                Console.WriteLine();
            }

            foreach (var line in answer.Lines.Take(Subject.MaxSelectCount))
            {
                Point selectedPos = line.SelectPos;

                Console.WriteLine($"select: {selectedPos.X:X}{selectedPos.Y:X}");

                for (int y = 0; y < Subject.PeaceCount.Y; y++)
                {
                    for (int x = 0; x < Subject.PeaceCount.X; x++)
                    {
                        var pos = interDisp2Data[x, y];
                        if (selectedPos == new Point(x, y))
                        {
                            Console.BackgroundColor = ConsoleColor.Gray;
                            Console.ForegroundColor = ConsoleColor.Black;
                        }
                        Console.Write($"{pos.X:X}{pos.Y:X} ");
                        Console.ResetColor();
                    }
                    Console.WriteLine();
                }
                result.TotalSwapCost += line.SwapDirections.Length * Subject.SwapCost;
                foreach (var dir in line.SwapDirections)
                {
                    Point swapTarget = selectedPos;

                    switch (dir)
                    {
                        case Answer.Direction.Up:
                            swapTarget.Y = swapTarget.Y - 1;
                            if (swapTarget.Y < 0)
                            {
                                swapTarget.Y += Subject.PeaceCount.Y;
                            }
                            break;
                        case Answer.Direction.Down:
                            swapTarget.Y = swapTarget.Y + 1;
                            if (swapTarget.Y >= Subject.PeaceCount.Y)
                            {
                                swapTarget.Y -= Subject.PeaceCount.Y;
                            }
                            break;
                        case Answer.Direction.Left:
                            swapTarget.X = swapTarget.X - 1;
                            if (swapTarget.X < 0)
                            {
                                swapTarget.X += Subject.PeaceCount.X;
                            }
                            break;
                        case Answer.Direction.Right:
                            swapTarget.X = swapTarget.X + 1;
                            if (swapTarget.X >= Subject.PeaceCount.X)
                            {
                                swapTarget.X -= Subject.PeaceCount.X;
                            }
                            break;
                        default:
                            throw new NotImplementedException();
                    }

                    var tmp = interDisp2Data[selectedPos.X, selectedPos.Y];
                    interDisp2Data[selectedPos.X, selectedPos.Y] = interDisp2Data[swapTarget.X, swapTarget.Y];
                    interDisp2Data[swapTarget.X, swapTarget.Y] = tmp;

                    selectedPos = swapTarget;

                    Console.WriteLine($"swap: {dir}");

                    for (int y = 0; y < Subject.PeaceCount.Y; y++)
                    {
                        for (int x = 0; x < Subject.PeaceCount.X; x++)
                        {
                            var pos = interDisp2Data[x, y];
                            if (selectedPos == new Point(x, y))
                            {
                                Console.BackgroundColor = ConsoleColor.Gray;
                                Console.ForegroundColor = ConsoleColor.Black;
                            }
                            Console.Write($"{pos.X:X}{pos.Y:X} ");
                            Console.ResetColor();
                        }
                        Console.WriteLine();
                    }
                }
            }

            // 答え合わせ

            result.InvalidPosPeaceCnt = 0;
            result.InvalidRotPeaceCnt = 0;

            for (int y = 0; y < Subject.PeaceCount.Y; y++)
            {
                for (int x = 0; x < Subject.PeaceCount.X; x++)
                {
                    var dispPos = new Point(x, y);
                    int dispIndex = y * Subject.PeaceCount.X + x;
                    var dataPos = interDisp2Data[x, y];

                    if (interDisp2Data[x, y] != dispPos)
                    {
                        result.InvalidPosPeaceCnt++;
                    }

                    var firstDispPos = IndexOf(firstDisp2Data, dataPos);
                    if (((int)Subject.Rotations[firstDispPos.Y][firstDispPos.X] + (int)answer.Rotations[dispIndex] * 90) % 360 != 0)
                    {
                        result.InvalidRotPeaceCnt++;
                    }
                }
            }

            return result;
        }

        static Point IndexOf<T>(T[,] ary, T val)
        {
            for (int y = 0; y < ary.GetLength(1); y++)
            {
                for (int x = 0; x < ary.GetLength(0); x++)
                {
                    if (ary[x, y].Equals(val))
                    {
                        return new Point(x, y);
                    }
                }
            }
            return new Point(-1, -1);
        }
    }
}

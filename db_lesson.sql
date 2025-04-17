CREATE TABLE departments (
    department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED AFTER email;

INSERT INTO departments (name) VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

INSERT INTO people (name, email, department_id, age, gender) VALUES
('山田太郎', 'taro.yamada@example.com', 1, 30, 1), -- 営業
('田中花子', 'hanako.tanaka@example.com', 1, 28, 2), -- 営業
('佐藤次郎', 'jiro.sato@example.com', 1, 35, 1), -- 営業
('鈴木一郎', 'ichiro.suzuki@example.com', 2, 25, 1), -- 開発
('高橋美咲', 'misaki.takahashi@example.com', 2, 29, 2), -- 開発
('伊藤健太', 'kenta.ito@example.com', 2, 32, 1), -- 開発
('渡辺さくら', 'sakura.watanabe@example.com', 2, 27, 2), -- 開発
('小林誠', 'makoto.kobayashi@example.com', 3, 40, 1), -- 経理
('加藤由美', 'yumi.kato@example.com', 4, 33, 2), -- 人事
('吉田大輔', 'daisuke.yoshida@example.com', 5, 31, 1); -- 情報システム

INSERT INTO reports (person_id, content) VALUES
(1, 'A社との契約交渉を行いました。'),
(2, 'B社へのプレゼン資料を作成しました。'),
(3, 'C社からの問い合わせに対応しました。'),
(4, '新機能の設計を行いました。'),
(5, 'バグ修正を行いました。'),
(6, 'テスト環境の構築を行いました。'),
(7, '請求書の処理を行いました。'),
(8, '社員の給与計算を行いました。'),
(9, '採用面接を実施しました。'),
(10, 'サーバーのメンテナンスを行いました。');

UPDATE people
SET department_id = (
    SELECT department_id
    FROM departments
    WHERE name = '営業'
)
WHERE department_id IS NULL AND name LIKE '%田%';

UPDATE people
SET department_id = (
    SELECT department_id
    FROM departments
    WHERE name = '開発'
)
WHERE department_id IS NULL AND name LIKE '%藤%';

UPDATE people
SET department_id = (
    SELECT department_id
    FROM departments
    WHERE name = '人事'
)
WHERE department_id IS NULL AND name LIKE '%鈴%';

UPDATE people
SET department_id = (
    SELECT department_id
    FROM departments
    WHERE name = '情報システム'
)
WHERE department_id IS NULL AND name LIKE '%島%';

UPDATE people
SET department_id = (
    SELECT department_id
    FROM departments
    WHERE name = '経理'
)
WHERE department_id IS NULL AND name LIKE '%沢%';

SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;

  people テーブルから特定の条件を満たすレコードのname（名前）、email（メールアドレス）、age（年齢）のカラムを取得します。
  FROM people: peopleという名前のテーブルからデータを取得します。
WHERE department_id = 1: department_id カラムの値が1であるレコードのみを抽出します。
SELECT name, email, age: 抽出されたレコードからname（名前）、email（メールアドレス）、age（年齢）のカラムの値を取得します。
ORDER BY created_at: 取得したレコードをcreated_atカラムの値で昇順に並べ替えます。

SELECT name
FROM people
WHERE (age BETWEEN 20 AND 29 AND gender = 2)
   OR (age BETWEEN 40 AND 49 AND gender = 1);

   SELECT name, age
FROM people
WHERE department_id = (SELECT department_id FROM departments WHERE name = '営業')
ORDER BY age ASC;

SELECT AVG(age) AS average_age
FROM people
WHERE department_id = (SELECT department_id FROM departments WHERE name = '開発')
  AND gender = 2;

  SELECT p.person_id, p.name, d.name, d.department_id, r.content 
    -> FROM
    -> people p
    -> JOIN
    -> departments d ON p.department_id = d.department_id
    -> JOIN
    -> reports r USING (person_id);
    
    SELECT p.name
FROM people p
LEFT JOIN reports r ON p.person_id = r.person_id
WHERE r.person_id IS NULL;